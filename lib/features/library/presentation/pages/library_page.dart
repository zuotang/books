import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_theme_extension.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/providers/library_preferences_provider.dart';
import '../../data/book_repository.dart';
import '../../domain/book_models.dart';
import '../widgets/book_spine.dart';
import '../widgets/section_header.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  static const List<(Color, Color)> _shelfPalettes = <(Color, Color)>[
    (Color(0xFFB7D8FF), Color(0xFF7FAFE8)),
    (Color(0xFFC6E4FF), Color(0xFF8EC0F1)),
    (Color(0xFFBFE7F4), Color(0xFF7EBFD8)),
    (Color(0xFFD0E3FF), Color(0xFF93B8F2)),
    (Color(0xFFC7F0FF), Color(0xFF87CAE8)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(libraryCategoriesProvider);
    final progressMapAsync = ref.watch(readingProgressMapProvider);
    final sortMode = ref.watch(librarySortModeProvider);
    final l10n = AppLocalizations.of(context)!;
    final tokens = Theme.of(context).extension<ReadingThemeTokens>()!;
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              tokens.paperGradientTop,
              tokens.paperGradientBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  l10n.librarySubtitle,
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  l10n.libraryTitle,
                                  style: theme.textTheme.displayLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          IconButton.filledTonal(
                            onPressed: () => context.go('/settings'),
                            icon: const Icon(Icons.tune_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
              categoriesAsync.when(
                data: (categories) {
                  final progressMap = progressMapAsync.valueOrNull ?? const {};
                  final sortedCategories = categories
                      .map(
                        (category) => BookCategory(
                          id: category.id,
                          title: category.title,
                          books: _sortBooks(
                            category.books,
                            sortMode,
                            progressMap,
                          ),
                        ),
                      )
                      .toList();
                  final recentBooks = sortedCategories
                      .expand((category) => category.books)
                      .where((book) => progressMap.containsKey(book.id))
                      .toList()
                    ..sort((left, right) {
                      final leftUpdatedAt = progressMap[left.id]!.updatedAt;
                      final rightUpdatedAt = progressMap[right.id]!.updatedAt;
                      return rightUpdatedAt.compareTo(leftUpdatedAt);
                    });
                  final sectionCount =
                      sortedCategories.length + (recentBooks.isEmpty ? 0 : 1);

                  return SliverList.builder(
                    itemCount: sectionCount,
                    itemBuilder: (context, index) {
                      final isRecentSection =
                          recentBooks.isNotEmpty && index == 0;

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                        child: isRecentSection
                            ? _LibrarySection(
                                title: l10n.recentReading,
                                books: recentBooks,
                                progressMap: progressMap,
                                trailingText: l10n.bookCount(recentBooks.length),
                                shelfColors: _shelfPalettes.first,
                              )
                            : _LibrarySection(
                                title: categories[
                                        recentBooks.isEmpty ? index : index - 1]
                                    .title,
                                books: sortedCategories[
                                        recentBooks.isEmpty ? index : index - 1]
                                    .books,
                                progressMap: progressMap,
                                trailingText: l10n.bookCount(
                                  sortedCategories[
                                          recentBooks.isEmpty ? index : index - 1]
                                      .books
                                      .length,
                                ),
                                shelfColors: _shelfPalettes[
                                  ((recentBooks.isEmpty ? index : index - 1) + 1) %
                                      _shelfPalettes.length
                                ],
                                onTap: () => context.go(
                                  '/collection/${sortedCategories[recentBooks.isEmpty ? index : index - 1].id}',
                                ),
                              ),
                      );
                    },
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 64),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 48,
                    ),
                    child: Text(
                      error.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: Center(
                    child: FilledButton(
                      onPressed: () => context.go('/manage'),
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.onSurface,
                        foregroundColor: theme.colorScheme.surface,
                        minimumSize: const Size(168, 56),
                      ),
                      child: Text(l10n.addBooks),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Book> _sortBooks(
    List<Book> books,
    LibrarySortMode sortMode,
    Map<String, ReadingProgress> progressMap,
  ) {
    final result = List<Book>.from(books);
    result.sort((left, right) {
      return switch (sortMode) {
        LibrarySortMode.title => left.title.compareTo(right.title),
        LibrarySortMode.author => left.author.compareTo(right.author),
        LibrarySortMode.recentRead => (progressMap[right.id]?.updatedAt ??
                DateTime.fromMillisecondsSinceEpoch(0))
            .compareTo(
              progressMap[left.id]?.updatedAt ??
                  DateTime.fromMillisecondsSinceEpoch(0),
            ),
      };
    });
    return result;
  }
}

class _LibrarySection extends StatelessWidget {
  const _LibrarySection({
    required this.title,
    required this.books,
    required this.progressMap,
    required this.trailingText,
    required this.shelfColors,
    this.onTap,
  });

  final String title;
  final List<Book> books;
  final Map<String, ReadingProgress> progressMap;
  final String trailingText;
  final (Color, Color) shelfColors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionHeader(
          title: title,
          trailingText: trailingText,
          onTap: onTap,
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 224,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      gradient: LinearGradient(
                        colors: <Color>[
                          shelfColors.$1,
                          shelfColors.$2,
                        ],
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: shelfColors.$2.withValues(alpha: 0.28),
                          blurRadius: 24,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: BookSpine(
                      book: book,
                      width: 102,
                      height: 164,
                      rotationY: -0.04,
                      readingProgress: progressMap[book.id],
                      showTitle: false,
                      onTap: () => context.go('/reader/${book.id}'),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 14),
                itemCount: books.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
