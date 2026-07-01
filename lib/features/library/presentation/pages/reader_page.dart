import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/providers/reader_preferences_provider.dart';
import '../../data/book_repository.dart';
import '../../domain/book_models.dart';

class ReaderPage extends ConsumerWidget {
  const ReaderPage({
    super.key,
    required this.bookId,
    this.chapterId,
  });

  final String bookId;
  final String? chapterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerAsync = ref.watch(readerPayloadProvider((bookId, chapterId)));
    final preferences = ref.watch(readerPreferencesProvider);
    final l10n = AppLocalizations.of(context)!;
    final readerTheme = ReaderSurfaceTheme.fromPreferences(preferences);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              readerTheme.backgroundTop,
              readerTheme.backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: readerAsync.when(
            data: (payload) {
              if (payload == null) {
                return Center(child: Text(l10n.bookNotFound));
              }

              return _ReaderSession(
                payload: payload,
                readerTheme: readerTheme,
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReaderSession extends ConsumerStatefulWidget {
  const _ReaderSession({
    required this.payload,
    required this.readerTheme,
  });

  final BookReaderPayload payload;
  final ReaderSurfaceTheme readerTheme;

  @override
  ConsumerState<_ReaderSession> createState() => _ReaderSessionState();
}

class _ReaderSessionState extends ConsumerState<_ReaderSession>
    with WidgetsBindingObserver {
  late final PageController _pageController;
  late final BookRepository _bookRepository;
  late int _chapterIndex;
  late int _pageIndex;
  late DateTime _lastStatsCheckpoint;
  bool _showChrome = true;
  Size? _lastViewportSize;
  ReaderPreferences? _lastPreferences;
  List<String> _pages = const <String>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bookRepository = ref.read(bookRepositoryProvider);
    _chapterIndex = widget.payload.chapters.indexWhere(
      (chapter) => chapter.id == widget.payload.currentChapter.id,
    );
    if (_chapterIndex < 0) {
      _chapterIndex = 0;
    }
    _pageIndex = math.max(0, widget.payload.initialPageIndex);
    _lastStatsCheckpoint = DateTime.now();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void didUpdateWidget(covariant _ReaderSession oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.payload.book.id != widget.payload.book.id ||
        oldWidget.payload.currentChapter.id != widget.payload.currentChapter.id ||
        oldWidget.payload.initialPageIndex != widget.payload.initialPageIndex) {
      _chapterIndex = widget.payload.chapters.indexWhere(
        (chapter) => chapter.id == widget.payload.currentChapter.id,
      );
      if (_chapterIndex < 0) {
        _chapterIndex = 0;
      }
      _pageIndex = math.max(0, widget.payload.initialPageIndex);
      _lastStatsCheckpoint = DateTime.now();
      _lastViewportSize = null;
      _lastPreferences = null;
      _pages = const <String>[];
      _pageController.jumpToPage(_pageIndex);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_flushReadingStats());
    unawaited(_persistProgress());
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      unawaited(_flushReadingStats());
      unawaited(_persistProgress());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentChapter = widget.payload.chapters[_chapterIndex];
    final readerPreferences = ref.watch(readerPreferencesProvider);
    final bookmarksAsync = ref.watch(bookBookmarksProvider(widget.payload.book.id));
    final currentBookmark = _findCurrentBookmark(
      bookmarksAsync.valueOrNull ?? const <BookBookmark>[],
      currentChapter.id,
      _pageIndex,
    );
    final readingTextStyle = theme.textTheme.bodyLarge!.copyWith(
      fontSize:
          (theme.textTheme.bodyLarge!.fontSize ?? 18) * readerPreferences.fontScale,
      height: readerPreferences.lineHeight,
      color: widget.readerTheme.textColor,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
        _ensurePages(
          viewportSize: viewportSize,
          textStyle: readingTextStyle,
          chapter: currentChapter,
          preferences: readerPreferences,
        );

        final currentPageCount = _pages.isEmpty ? 1 : _pages.length;
        final currentPage = math.min(_pageIndex + 1, currentPageCount);

        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            unawaited(_flushReadingStats());
            unawaited(_persistProgress());
          },
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: _showChrome
                        ? _ReaderHeader(
                            book: widget.payload.book,
                            chapterTitle: currentChapter.title,
                            textColor: widget.readerTheme.textColor,
                            hasBookmark: currentBookmark != null,
                            onBack: () async {
                              await _flushReadingStats();
                              await _persistProgress();
                              if (mounted && context.mounted) {
                                context.pop();
                              }
                            },
                            onSearch: () => _openSearchSheet(
                              context,
                              readerPreferences,
                              readingTextStyle,
                              viewportSize,
                            ),
                            onBookmarks: _openBookmarksSheet,
                            onContents: _openContentsSheet,
                            onSettings: () => _openAppearanceSheet(
                              context,
                              readerPreferences,
                              widget.readerTheme,
                            ),
                          )
                        : const SizedBox(height: 16),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.readerTheme.cardColor,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: currentPageCount,
                            onPageChanged: (index) {
                              setState(() {
                                _pageIndex = index;
                              });
                              unawaited(_persistProgress());
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  readerPreferences.pagePadding,
                                  24,
                                  readerPreferences.pagePadding,
                                  24,
                                ),
                                child: ReaderPageContent(
                                  text: _pages.isEmpty ? '' : _pages[index],
                                  textStyle: readingTextStyle,
                                  textAlign: readerPreferences.textAlignMode ==
                                          ReaderTextAlignMode.justify
                                      ? TextAlign.justify
                                      : TextAlign.left,
                                  paragraphSpacing:
                                      readerPreferences.paragraphSpacing,
                                  paragraphIndent:
                                      readerPreferences.paragraphIndent,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: _showChrome
                        ? _ReaderFooter(
                            chapterIndex: _chapterIndex + 1,
                            chapterCount: widget.payload.chapters.length,
                            pageIndex: currentPage,
                            pageCount: currentPageCount,
                          )
                        : const SizedBox(height: 24),
                  ),
                ],
              ),
              Positioned.fill(
                child: _ReaderTapZones(
                  topInset: _showChrome ? 88 : 0,
                  bottomInset: _showChrome ? 72 : 0,
                  onPrevious: _goPrevious,
                  onNext: _goNext,
                  onCenter: () {
                    setState(() {
                      _showChrome = !_showChrome;
                      _lastViewportSize = null;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _currentProgress() {
    final chapterCount = math.max(1, widget.payload.chapters.length);
    final pageCount = math.max(1, _pages.length);
    return (_chapterIndex + (_pageIndex / pageCount)) / chapterCount;
  }

  String _currentExcerpt() {
    if (_pages.isEmpty) {
      return '';
    }

    final compact = _pages[_pageIndex].replaceAll('\n', ' ').trim();
    if (compact.length <= 72) {
      return compact;
    }
    return '${compact.substring(0, 72)}...';
  }

  BookBookmark? _findCurrentBookmark(
    List<BookBookmark> bookmarks,
    String chapterId,
    int pageIndex,
  ) {
    for (final bookmark in bookmarks) {
      if (bookmark.chapterId == chapterId && bookmark.pageIndex == pageIndex) {
        return bookmark;
      }
    }
    return null;
  }

  List<_ReaderSearchResult> _searchInBook({
    required String keyword,
    required Size viewportSize,
    required TextStyle textStyle,
    required ReaderPreferences preferences,
  }) {
    final normalizedKeyword = keyword.trim();
    if (normalizedKeyword.isEmpty) {
      return const <_ReaderSearchResult>[];
    }

    final contentWidth = math.max(
      180.0,
      viewportSize.width - 84 - (preferences.pagePadding * 2),
    );
    final contentHeight = math.max(
      220.0,
      viewportSize.height - (_showChrome ? 220 : 96),
    );

    final results = <_ReaderSearchResult>[];
    for (final chapter in widget.payload.chapters) {
      final pages = _paginateChapter(
        chapter: chapter,
        textStyle: textStyle,
        contentWidth: contentWidth,
        contentHeight: contentHeight,
        paragraphSpacing: preferences.paragraphSpacing,
        paragraphIndent: preferences.paragraphIndent,
      );

      for (var pageIndex = 0; pageIndex < pages.length; pageIndex++) {
        final page = pages[pageIndex];
        final hitIndex = page.indexOf(normalizedKeyword);
        if (hitIndex < 0) {
          continue;
        }

        final start = math.max(0, hitIndex - 18);
        final end = math.min(
          page.length,
          hitIndex + normalizedKeyword.length + 36,
        );
        results.add(
          _ReaderSearchResult(
            chapterId: chapter.id,
            chapterTitle: chapter.title,
            pageIndex: pageIndex,
            excerpt: page.substring(start, end).replaceAll('\n', ' ').trim(),
          ),
        );
      }
    }

    return results;
  }

  Future<void> _openSearchSheet(
    BuildContext context,
    ReaderPreferences preferences,
    TextStyle textStyle,
    Size viewportSize,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    var loading = false;
    List<_ReaderSearchResult> results = const <_ReaderSearchResult>[];

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> runSearch() async {
              final keyword = controller.text.trim();
              if (keyword.isEmpty) {
                setModalState(() {
                  results = const <_ReaderSearchResult>[];
                  loading = false;
                });
                return;
              }

              setModalState(() {
                loading = true;
              });

              final nextResults = _searchInBook(
                keyword: keyword,
                viewportSize: viewportSize,
                textStyle: textStyle,
                preferences: preferences,
              );

              setModalState(() {
                results = nextResults;
                loading = false;
              });
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  24 + MediaQuery.viewInsetsOf(context).bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          l10n.searchInBook,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: l10n.searchPlaceholder,
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                      onSubmitted: (_) => runSearch(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: math.min(
                        MediaQuery.sizeOf(context).height * 0.56,
                        420,
                      ),
                      child: loading
                          ? const Center(child: CircularProgressIndicator())
                          : controller.text.trim().isEmpty
                              ? Center(child: Text(l10n.searchEmpty))
                              : results.isEmpty
                                  ? Center(child: Text(l10n.searchNoResult))
                                  : ListView.separated(
                                      itemCount: results.length,
                                      separatorBuilder: (context, index) =>
                                          const Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        final result = results[index];
                                        return ListTile(
                                          title: Text(result.chapterTitle),
                                          subtitle: Text(
                                            '第${result.pageIndex + 1}页 · ${result.excerpt}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            await _jumpToSearchResult(result);
                                          },
                                        );
                                      },
                                    ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.icon(
                        onPressed: runSearch,
                        icon: const Icon(Icons.search_rounded),
                        label: Text(l10n.searchInBook),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openAppearanceSheet(
    BuildContext context,
    ReaderPreferences preferences,
    ReaderSurfaceTheme readerTheme,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => _ReaderAppearanceSheet(
        preferences: preferences,
        readerTheme: readerTheme,
        onFontScaleChanged: (value) => _updatePreferences(fontScale: value),
        onLineHeightChanged: (value) => _updatePreferences(lineHeight: value),
        onPagePaddingChanged: (value) => _updatePreferences(pagePadding: value),
        onParagraphSpacingChanged: (value) =>
            _updatePreferences(paragraphSpacing: value),
        onParagraphIndentChanged: (value) =>
            _updatePreferences(paragraphIndent: value),
        onThemePresetChanged: (value) => _updatePreferences(themePreset: value),
        onTextAlignModeChanged: (value) =>
            _updatePreferences(textAlignMode: value),
      ),
    );
  }

  void _updatePreferences({
    double? fontScale,
    double? lineHeight,
    double? pagePadding,
    double? paragraphSpacing,
    double? paragraphIndent,
    ReaderThemePreset? themePreset,
    ReaderTextAlignMode? textAlignMode,
  }) {
    ref.read(readerPreferencesProvider.notifier).update(
          fontScale: fontScale,
          lineHeight: lineHeight,
          pagePadding: pagePadding,
          paragraphSpacing: paragraphSpacing,
          paragraphIndent: paragraphIndent,
          themePreset: themePreset,
          textAlignMode: textAlignMode,
        );
    setState(() {
      _lastViewportSize = null;
      _lastPreferences = null;
    });
  }

  void _ensurePages({
    required Size viewportSize,
    required TextStyle textStyle,
    required BookChapter chapter,
    required ReaderPreferences preferences,
  }) {
    if (_lastViewportSize == viewportSize &&
        _lastPreferences == preferences &&
        _pages.isNotEmpty) {
      return;
    }

    final contentWidth = math.max(
      180.0,
      viewportSize.width - 84 - (preferences.pagePadding * 2),
    );
    final contentHeight = math.max(
      220.0,
      viewportSize.height - (_showChrome ? 220 : 96),
    );

    _pages = _paginateChapter(
      chapter: chapter,
      textStyle: textStyle,
      contentWidth: contentWidth,
      contentHeight: contentHeight,
      paragraphSpacing: preferences.paragraphSpacing,
      paragraphIndent: preferences.paragraphIndent,
    );
    _lastViewportSize = viewportSize;
    _lastPreferences = preferences;

    if (_pages.isEmpty) {
      _pages = <String>[''];
    }

    if (_pageIndex >= _pages.length) {
      _pageIndex = _pages.length - 1;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      if (_pageController.hasClients &&
          _pageController.page?.round() != _pageIndex) {
        _pageController.jumpToPage(_pageIndex);
      }
    });
  }

  List<String> _paginateChapter({
    required BookChapter chapter,
    required TextStyle textStyle,
    required double contentWidth,
    required double contentHeight,
    required double paragraphSpacing,
    required double paragraphIndent,
  }) {
    final fontSize = textStyle.fontSize ?? 18;
    final lineHeight = (textStyle.height ?? 1.85) * fontSize;
    final charsPerLine =
        math.max(12, (contentWidth / (fontSize * 0.82)).floor());
    final linesPerPage = math.max(8, (contentHeight / lineHeight).floor());
    final charsPerPage = charsPerLine * linesPerPage;
    final extraUnitsPerParagraph = paragraphIndent.round() +
        math.max(1, (paragraphSpacing * charsPerLine / 3).round());

    final pages = <String>[];
    final buffer = StringBuffer();
    var currentUnits = 0;

    void pushPage() {
      final text = buffer.toString().trim();
      if (text.isNotEmpty) {
        pages.add(text);
      }
      buffer.clear();
      currentUnits = 0;
    }

    for (final paragraph in chapter.paragraphs) {
      final normalized = paragraph.trim();
      if (normalized.isEmpty) {
        continue;
      }

      final units = normalized.length + extraUnitsPerParagraph;
      if (currentUnits > 0 && currentUnits + units > charsPerPage) {
        pushPage();
      }

      if (normalized.length > charsPerPage) {
        final chunks = _splitLongParagraph(normalized, charsPerPage);
        for (final chunk in chunks) {
          if (currentUnits > 0) {
            pushPage();
          }
          buffer.write(chunk);
          buffer.write('\n\n');
          currentUnits = chunk.length + extraUnitsPerParagraph.toInt();
          pushPage();
        }
        continue;
      }

      buffer.write(normalized);
      buffer.write('\n\n');
      currentUnits += units.toInt();
    }

    pushPage();
    return pages;
  }

  List<String> _splitLongParagraph(String paragraph, int chunkSize) {
    final chunks = <String>[];
    var start = 0;
    while (start < paragraph.length) {
      final end = math.min(paragraph.length, start + chunkSize);
      chunks.add(paragraph.substring(start, end));
      start = end;
    }
    return chunks;
  }

  Future<void> _goPrevious() async {
    if (_pageIndex > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    if (_chapterIndex <= 0) {
      return;
    }

    setState(() {
      _chapterIndex -= 1;
      _pageIndex = 0;
      _lastViewportSize = null;
      _lastPreferences = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _pageIndex = _pages.length - 1;
      _pageController.jumpToPage(_pageIndex);
      unawaited(_persistProgress());
    });
  }

  Future<void> _goNext() async {
    if (_pageIndex < _pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    if (_chapterIndex >= widget.payload.chapters.length - 1) {
      return;
    }

    setState(() {
      _chapterIndex += 1;
      _pageIndex = 0;
      _lastViewportSize = null;
      _lastPreferences = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _pageController.jumpToPage(0);
      unawaited(_persistProgress());
    });
  }

  Future<void> _persistProgress() async {
    final currentChapter = widget.payload.chapters[_chapterIndex];
    final progress = _currentProgress();

    await _bookRepository.saveReadingProgress(
      bookId: widget.payload.book.id,
      progress: progress,
      chapterId: currentChapter.id,
      chapterLabel: currentChapter.title,
      pageIndex: _pageIndex,
    );
    if (mounted) {
      ref.invalidate(readingProgressMapProvider);
    }
  }

  Future<void> _flushReadingStats() async {
    final now = DateTime.now();
    final readingSeconds = now.difference(_lastStatsCheckpoint).inSeconds;
    _lastStatsCheckpoint = now;

    if (readingSeconds <= 0) {
      return;
    }

    await _bookRepository.recordReadingSession(
      bookId: widget.payload.book.id,
      readingSeconds: readingSeconds,
      progress: _currentProgress(),
    );
    if (mounted) {
      ref.invalidate(readingOverviewProvider);
    }
  }

  Future<void> _toggleBookmark() async {
    final currentChapter = widget.payload.chapters[_chapterIndex];
    final current = await _bookRepository.getBookmarkAtPosition(
      bookId: widget.payload.book.id,
      chapterId: currentChapter.id,
      pageIndex: _pageIndex,
    );

    if (current != null) {
      await _bookRepository.deleteBookmark(current.id);
    } else {
      await _bookRepository.saveBookmark(
        bookId: widget.payload.book.id,
        chapterId: currentChapter.id,
        chapterTitle: currentChapter.title,
        pageIndex: _pageIndex,
        progress: _currentProgress(),
        excerpt: _currentExcerpt(),
      );
    }

    if (mounted) {
      ref.invalidate(bookBookmarksProvider(widget.payload.book.id));
    }
  }

  Future<void> _jumpToBookmark(BookBookmark bookmark) async {
    final targetChapterIndex = widget.payload.chapters.indexWhere(
      (chapter) => chapter.id == bookmark.chapterId,
    );
    if (targetChapterIndex < 0) {
      return;
    }

    setState(() {
      _chapterIndex = targetChapterIndex;
      _pageIndex = bookmark.pageIndex;
      _lastViewportSize = null;
      _lastPreferences = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _pageController.jumpToPage(_pageIndex);
      unawaited(_persistProgress());
    });
  }

  Future<void> _jumpToSearchResult(_ReaderSearchResult result) async {
    final targetChapterIndex = widget.payload.chapters.indexWhere(
      (chapter) => chapter.id == result.chapterId,
    );
    if (targetChapterIndex < 0) {
      return;
    }

    setState(() {
      _chapterIndex = targetChapterIndex;
      _pageIndex = result.pageIndex;
      _lastViewportSize = null;
      _lastPreferences = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _pageController.jumpToPage(_pageIndex);
      unawaited(_persistProgress());
    });
  }

  Future<void> _openBookmarksSheet() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final bookmarksAsync =
                ref.watch(bookBookmarksProvider(widget.payload.book.id));

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Row(
                      children: <Widget>[
                        Text(
                          l10n.bookmarks,
                          style: theme.textTheme.titleLarge,
                        ),
                        const Spacer(),
                        FilledButton.tonalIcon(
                          onPressed: () async {
                            await _toggleBookmark();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.bookmark_add_rounded),
                          label: Text(l10n.toggleBookmark),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: bookmarksAsync.when(
                      data: (bookmarks) {
                        if (bookmarks.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(l10n.noBookmarks),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: bookmarks.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final bookmark = bookmarks[index];
                            return ListTile(
                              title: Text(bookmark.chapterTitle),
                              subtitle: Text(
                                '第${bookmark.pageIndex + 1}页 · ${bookmark.excerpt}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  await _bookRepository.deleteBookmark(
                                    bookmark.id,
                                  );
                                  ref.invalidate(
                                    bookBookmarksProvider(widget.payload.book.id),
                                  );
                                },
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                              onTap: () async {
                                Navigator.of(context).pop();
                                await _jumpToBookmark(bookmark);
                              },
                            );
                          },
                        );
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stack) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(error.toString()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openContentsSheet() {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        final theme = Theme.of(context);

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      l10n.tableOfContents,
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.payload.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = widget.payload.chapters[index];
                    final active = index == _chapterIndex;
                    return ListTile(
                      selected: active,
                      title: Text(chapter.title),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _chapterIndex = index;
                          _pageIndex = 0;
                          _lastViewportSize = null;
                          _lastPreferences = null;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) {
                            return;
                          }
                          _pageController.jumpToPage(0);
                          unawaited(_persistProgress());
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReaderHeader extends StatelessWidget {
  const _ReaderHeader({
    required this.book,
    required this.chapterTitle,
    required this.textColor,
    required this.hasBookmark,
    required this.onBack,
    required this.onSearch,
    required this.onBookmarks,
    required this.onContents,
    required this.onSettings,
  });

  final Book book;
  final String chapterTitle;
  final Color textColor;
  final bool hasBookmark;
  final VoidCallback onBack;
  final VoidCallback onSearch;
  final VoidCallback onBookmarks;
  final VoidCallback onContents;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
      child: Row(
        children: <Widget>[
          FilledButton.tonalIcon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            label: Text(l10n.backToLibrary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  chapterTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: textColor.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          IconButton.filledTonal(
            onPressed: onSearch,
            icon: const Icon(Icons.search_rounded),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton.filledTonal(
            onPressed: onBookmarks,
            icon: Icon(
              hasBookmark ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton.filledTonal(
            onPressed: onContents,
            icon: const Icon(Icons.format_list_bulleted_rounded),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton.filledTonal(
            onPressed: onSettings,
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
    );
  }
}

class _ReaderAppearanceSheet extends StatelessWidget {
  const _ReaderAppearanceSheet({
    required this.preferences,
    required this.readerTheme,
    required this.onFontScaleChanged,
    required this.onLineHeightChanged,
    required this.onPagePaddingChanged,
    required this.onParagraphSpacingChanged,
    required this.onParagraphIndentChanged,
    required this.onThemePresetChanged,
    required this.onTextAlignModeChanged,
  });

  final ReaderPreferences preferences;
  final ReaderSurfaceTheme readerTheme;
  final ValueChanged<double> onFontScaleChanged;
  final ValueChanged<double> onLineHeightChanged;
  final ValueChanged<double> onPagePaddingChanged;
  final ValueChanged<double> onParagraphSpacingChanged;
  final ValueChanged<double> onParagraphIndentChanged;
  final ValueChanged<ReaderThemePreset> onThemePresetChanged;
  final ValueChanged<ReaderTextAlignMode> onTextAlignModeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.readerAppearance,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.readerThemePreset, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ReaderThemePreset.values
                  .map(
                    (preset) => _ReaderThemeChip(
                      label: _themePresetLabel(l10n, preset),
                      selected: preferences.themePreset == preset,
                      theme: ReaderSurfaceTheme.fromPreset(preset),
                      onTap: () => onThemePresetChanged(preset),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.readerTextAlign, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ReaderTextAlignMode.values
                  .map(
                    (mode) => ChoiceChip(
                      label: Text(_textAlignLabel(l10n, mode)),
                      selected: preferences.textAlignMode == mode,
                      onSelected: (_) => onTextAlignModeChanged(mode),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ReaderSliderRow(
              label: l10n.fontSize,
              valueText: preferences.fontScale.toStringAsFixed(2),
              min: 0.85,
              max: 1.45,
              value: preferences.fontScale,
              onChanged: onFontScaleChanged,
            ),
            _ReaderSliderRow(
              label: l10n.lineHeight,
              valueText: preferences.lineHeight.toStringAsFixed(2),
              min: 1.5,
              max: 2.2,
              value: preferences.lineHeight,
              onChanged: onLineHeightChanged,
            ),
            _ReaderSliderRow(
              label: l10n.readerPagePadding,
              valueText: preferences.pagePadding.toStringAsFixed(0),
              min: 16,
              max: 40,
              value: preferences.pagePadding,
              onChanged: onPagePaddingChanged,
            ),
            _ReaderSliderRow(
              label: l10n.readerParagraphSpacing,
              valueText: preferences.paragraphSpacing.toStringAsFixed(1),
              min: 0.4,
              max: 2.0,
              value: preferences.paragraphSpacing,
              onChanged: onParagraphSpacingChanged,
            ),
            _ReaderSliderRow(
              label: l10n.readerParagraphIndent,
              valueText: preferences.paragraphIndent.toStringAsFixed(0),
              min: 0,
              max: 4,
              value: preferences.paragraphIndent,
              onChanged: onParagraphIndentChanged,
            ),
            const SizedBox(height: AppSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                color: readerTheme.cardColor,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: readerTheme.textColor.withValues(alpha: 0.08),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  l10n.readerPreviewText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: readerTheme.textColor,
                    height: preferences.lineHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _themePresetLabel(AppLocalizations l10n, ReaderThemePreset preset) {
    return switch (preset) {
      ReaderThemePreset.paper => l10n.readerThemePaper,
      ReaderThemePreset.mist => l10n.readerThemeMist,
      ReaderThemePreset.night => l10n.readerThemeNight,
    };
  }

  String _textAlignLabel(AppLocalizations l10n, ReaderTextAlignMode mode) {
    return switch (mode) {
      ReaderTextAlignMode.justify => l10n.readerTextAlignJustify,
      ReaderTextAlignMode.left => l10n.readerTextAlignLeft,
    };
  }
}

class ReaderPageContent extends StatelessWidget {
  const ReaderPageContent({
    super.key,
    required this.text,
    required this.textStyle,
    required this.textAlign,
    required this.paragraphSpacing,
    required this.paragraphIndent,
  });

  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final double paragraphSpacing;
  final double paragraphIndent;

  @override
  Widget build(BuildContext context) {
    final paragraphs = text
        .split('\n\n')
        .where((value) => value.trim().isNotEmpty)
        .toList();
    final indent = '　' * paragraphIndent.round();
    final gap = (textStyle.fontSize ?? 18) * paragraphSpacing;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < paragraphs.length; index++) ...<Widget>[
            Text(
              '$indent${paragraphs[index].trim()}',
              style: textStyle,
              textAlign: textAlign,
            ),
            if (index < paragraphs.length - 1) SizedBox(height: gap),
          ],
        ],
      ),
    );
  }
}

class _ReaderSliderRow extends StatelessWidget {
  const _ReaderSliderRow({
    required this.label,
    required this.valueText,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String valueText;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(label, style: theme.textTheme.labelLarge),
            const Spacer(),
            Text(valueText, style: theme.textTheme.bodySmall),
          ],
        ),
        Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}

class _ReaderThemeChip extends StatelessWidget {
  const _ReaderThemeChip({
    required this.label,
    required this.selected,
    required this.theme,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final ReaderSurfaceTheme theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected ? colorScheme.primary : colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: theme.textColor.withValues(alpha: 0.18),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReaderFooter extends StatelessWidget {
  const _ReaderFooter({
    required this.chapterIndex,
    required this.chapterCount,
    required this.pageIndex,
    required this.pageCount,
  });

  final int chapterIndex;
  final int chapterCount;
  final int pageIndex;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColors.nightCard.withValues(alpha: 0.94)
              : AppColors.ink.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: <Widget>[
              Text(
                'Chapter $chapterIndex / $chapterCount',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '$pageIndex / $pageCount',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReaderTapZones extends StatelessWidget {
  const _ReaderTapZones({
    required this.topInset,
    required this.bottomInset,
    required this.onPrevious,
    required this.onNext,
    required this.onCenter,
  });

  final double topInset;
  final double bottomInset;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onCenter;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: topInset,
              bottom: bottomInset,
              width: width * 0.4,
              child: _TapZone(onTap: onPrevious),
            ),
            Positioned(
              right: 0,
              top: topInset,
              bottom: bottomInset,
              width: width * 0.4,
              child: _TapZone(onTap: onNext),
            ),
            Positioned(
              left: width * 0.18,
              right: width * 0.18,
              top: topInset,
              height: math.max(64, (height - topInset - bottomInset) * 0.24),
              child: _TapZone(onTap: onPrevious),
            ),
            Positioned(
              left: width * 0.18,
              right: width * 0.18,
              bottom: bottomInset,
              height: math.max(64, (height - topInset - bottomInset) * 0.24),
              child: _TapZone(onTap: onNext),
            ),
            Positioned(
              left: width * 0.43,
              right: width * 0.43,
              top: topInset + math.max(84, (height - topInset - bottomInset) * 0.3),
              bottom:
                  bottomInset +
                      math.max(84, (height - topInset - bottomInset) * 0.3),
              child: _TapZone(onTap: onCenter),
            ),
          ],
        );
      },
    );
  }
}

class _TapZone extends StatelessWidget {
  const _TapZone({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
      ),
    );
  }
}

class ReaderSurfaceTheme {
  const ReaderSurfaceTheme({
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.cardColor,
    required this.textColor,
  });

  factory ReaderSurfaceTheme.fromPreferences(ReaderPreferences preferences) {
    return ReaderSurfaceTheme.fromPreset(preferences.themePreset);
  }

  factory ReaderSurfaceTheme.fromPreset(ReaderThemePreset preset) {
    return switch (preset) {
      ReaderThemePreset.paper => const ReaderSurfaceTheme(
          backgroundTop: AppColors.paperSoft,
          backgroundBottom: AppColors.paper,
          cardColor: Colors.white,
          textColor: AppColors.ink,
        ),
      ReaderThemePreset.mist => const ReaderSurfaceTheme(
          backgroundTop: Color(0xFFE7EEF3),
          backgroundBottom: Color(0xFFD9E4EB),
          cardColor: Color(0xFFF4F7F8),
          textColor: Color(0xFF1E2830),
        ),
      ReaderThemePreset.night => const ReaderSurfaceTheme(
          backgroundTop: Color(0xFF141820),
          backgroundBottom: Color(0xFF0D1017),
          cardColor: AppColors.nightCard,
          textColor: AppColors.nightInk,
        ),
    };
  }

  final Color backgroundTop;
  final Color backgroundBottom;
  final Color cardColor;
  final Color textColor;
}

class _ReaderSearchResult {
  const _ReaderSearchResult({
    required this.chapterId,
    required this.chapterTitle,
    required this.pageIndex,
    required this.excerpt,
  });

  final String chapterId;
  final String chapterTitle;
  final int pageIndex;
  final String excerpt;
}
