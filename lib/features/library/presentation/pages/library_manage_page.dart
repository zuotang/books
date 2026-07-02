import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/providers/library_preferences_provider.dart';
import '../../application/services/book_import_source.dart';
import '../../data/book_repository.dart';
import '../../domain/book_models.dart';

class LibraryManagePage extends ConsumerStatefulWidget {
  const LibraryManagePage({super.key});

  @override
  ConsumerState<LibraryManagePage> createState() => _LibraryManagePageState();
}

class _LibraryManagePageState extends ConsumerState<LibraryManagePage> {
  bool _importing = false;
  final AppLogger _logger = AppLogger();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final importedBooksAsync = ref.watch(importedBooksProvider);
    final readingOverviewAsync = ref.watch(readingOverviewProvider);
    final sortMode = ref.watch(librarySortModeProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.tonalIcon(
                onPressed: context.pop,
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                label: Text(
                  l10n.backToLibrary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.manageLibrary,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            _ManageCard(
              title: l10n.sortBooks,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: SegmentedButton<LibrarySortMode>(
                    segments: <ButtonSegment<LibrarySortMode>>[
                      ButtonSegment(
                        value: LibrarySortMode.recentRead,
                        label: Text(l10n.sortRecentRead),
                      ),
                      ButtonSegment(
                        value: LibrarySortMode.title,
                        label: Text(l10n.sortTitle),
                      ),
                      ButtonSegment(
                        value: LibrarySortMode.author,
                        label: Text(l10n.sortAuthor),
                      ),
                    ],
                    selected: <LibrarySortMode>{sortMode},
                    showSelectedIcon: false,
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onSelectionChanged: (selection) {
                      ref
                          .read(librarySortModeProvider.notifier)
                          .update(selection.first);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _ManageCard(
              title: l10n.addBooks,
              subtitle: l10n.importBooksHint,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: _importing ? null : _pickFilesAndImport,
                    icon: _importing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.upload_file_rounded),
                    label: Text(l10n.importFilesAction),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: _importing ? null : _pickDirectoryAndImport,
                    icon: const Icon(Icons.folder_open_rounded),
                    label: Text(l10n.importDirectoryAction),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _ManageCard(
              title: l10n.readingStats,
              child: readingOverviewAsync.when(
                data: (overview) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${l10n.totalBooksStarted}: ${overview.totalBooksStarted}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.totalReadingTime}: ${_formatDuration(overview.totalReadingSeconds)}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.lastReadAt}: ${_formatDateTime(overview.lastReadAt)}',
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text(error.toString()),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _ManageCard(
              title: l10n.importedBooks,
              child: importedBooksAsync.when(
                data: (books) {
                  if (books.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(l10n.noImportedBooks),
                    );
                  }

                  return Column(
                    children: books
                        .map(
                          (book) => _ManagedBookTile(
                            book: book,
                            onEdit: () => _editBook(book),
                            onDelete: () => _deleteBook(book),
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(error.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFilesAndImport() async {
    _logger.info('打开文件选择器');
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.custom,
      allowedExtensions: const <String>['txt', 'epub'],
    );

    final sources = result?.files
            .where(
              (file) =>
                  file.name.trim().isNotEmpty &&
                  (file.path != null || file.bytes != null),
            )
            .map(
              (file) => BookImportSource(
                name: file.name,
                path: file.path,
                bytes: file.bytes,
              ),
            )
            .toList() ??
        const <BookImportSource>[];

    _logger.info('文件选择完成，数量=${result?.files.length ?? 0}');
    for (final file in result?.files ?? const <PlatformFile>[]) {
      _logger.info(
        '选择结果: name=${file.name}, ext=${file.extension}, hasPath=${file.path != null}, hasBytes=${file.bytes != null}, bytesLength=${file.bytes?.length ?? 0}, size=${file.size}',
      );
    }

    if (sources.isEmpty) {
      _logger.info('没有可导入的有效文件');
      return;
    }

    await _runImport(
      () => ref.read(bookRepositoryProvider).importBooks(sources),
    );
  }

  Future<void> _pickDirectoryAndImport() async {
    _logger.info('打开目录选择器');
    final directoryPath = await FilePicker.platform.getDirectoryPath();
    _logger.info('目录选择结果: ${directoryPath ?? 'null'}');
    if (directoryPath == null || directoryPath.trim().isEmpty) {
      return;
    }

    await _runImport(
      () => ref.read(bookRepositoryProvider).importBooksFromDirectory(
            directoryPath,
          ),
    );
  }

  Future<void> _runImport(Future<void> Function() action) async {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _importing = true;
    });

    try {
      _logger.info('开始执行导入动作');
      await action();
      _logger.info('导入动作执行成功');
      ref.invalidate(importedBooksProvider);
      ref.invalidate(libraryCategoriesProvider);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.importSuccess)));
      }
    } catch (error, stackTrace) {
      _logger.error('导入失败', error, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${l10n.importFailed}: $error')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _importing = false;
        });
      }
    }
  }

  Future<void> _editBook(Book book) async {
    final l10n = AppLocalizations.of(context)!;
    final titleController = TextEditingController(text: book.title);
    final authorController = TextEditingController(text: book.author);

    final shouldSave =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(l10n.editMetadata),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: l10n.bookTitleLabel),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: authorController,
                    decoration: InputDecoration(
                      labelText: l10n.bookAuthorLabel,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.cancelAction),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(l10n.saveAction),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!shouldSave) {
      titleController.dispose();
      authorController.dispose();
      return;
    }

    final nextTitle = titleController.text.trim();
    final nextAuthor = authorController.text.trim();
    titleController.dispose();
    authorController.dispose();

    await ref
        .read(bookRepositoryProvider)
        .updateBookMetadata(
          bookId: book.id,
          title: nextTitle,
          author: nextAuthor,
        );
    ref.invalidate(importedBooksProvider);
    ref.invalidate(libraryCategoriesProvider);
  }

  Future<void> _deleteBook(Book book) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(l10n.deleteBook),
              content: Text(l10n.confirmDeleteBook),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.cancelAction),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(l10n.deleteBook),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await ref.read(bookRepositoryProvider).deleteBook(book.id);
    ref.invalidate(importedBooksProvider);
    ref.invalidate(libraryCategoriesProvider);
    ref.invalidate(readingProgressMapProvider);
    ref.invalidate(readingOverviewProvider);
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) {
      return '-';
    }
    return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')} '
        '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
}

class _ManageCard extends StatelessWidget {
  const _ManageCard({required this.title, required this.child, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (subtitle != null) ...<Widget>[
              const SizedBox(height: 4),
              Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ManagedBookTile extends StatelessWidget {
  const _ManagedBookTile({
    required this.book,
    required this.onEdit,
    required this.onDelete,
  });

  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Wrap(
        spacing: 8,
        children: <Widget>[
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }
}
