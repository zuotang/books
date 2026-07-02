import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logging/app_logger.dart';
import '../../../data/local/db/app_database.dart';
import '../../../data/local/db/app_database_provider.dart';
import '../application/services/book_import_source.dart';
import '../application/services/epub_importer.dart';
import '../application/services/txt_importer.dart';
import '../domain/book_models.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return BookRepository(database);
});

final libraryCategoriesProvider = FutureProvider<List<BookCategory>>((ref) {
  return ref.watch(bookRepositoryProvider).getCategories();
});

final bookCategoryProvider =
    FutureProvider.family<BookCategory?, String>((ref, categoryId) {
  return ref.watch(bookRepositoryProvider).findCategory(categoryId);
});

final bookDetailsProvider = FutureProvider.family<Book?, String>((ref, bookId) {
  return ref.watch(bookRepositoryProvider).findBook(bookId);
});

final importedBooksProvider = FutureProvider<List<Book>>((ref) {
  return ref.watch(bookRepositoryProvider).getImportedBooks();
});

final readingOverviewProvider = FutureProvider<ReadingOverview>((ref) {
  return ref.watch(bookRepositoryProvider).getReadingOverview();
});

final readingProgressMapProvider =
    FutureProvider<Map<String, ReadingProgress>>((ref) {
  return ref.watch(bookRepositoryProvider).getReadingProgressMap();
});

final bookBookmarksProvider =
    FutureProvider.autoDispose.family<List<BookBookmark>, String>((ref, bookId) {
  return ref.watch(bookRepositoryProvider).getBookmarks(bookId);
});

final readerPayloadProvider =
    FutureProvider.autoDispose.family<BookReaderPayload?, (String, String?)>(
  (ref, params) {
    return ref.watch(bookRepositoryProvider).getReaderPayload(
          bookId: params.$1,
          chapterId: params.$2,
        );
  },
);

class BookRepository {
  BookRepository(this._database);

  final AppDatabase _database;
  final AppLogger _logger = AppLogger();
  static final _epubImporter = EpubImporter();
  static final _txtImporter = TxtImporter();

  Future<List<BookCategory>> getCategories() {
    return _database.fetchCategoriesWithBooks();
  }

  Future<BookCategory?> findCategory(String categoryId) {
    return _database.fetchCategory(categoryId);
  }

  Future<Book?> findBook(String bookId) {
    return _database.fetchBook(bookId);
  }

  Future<List<Book>> getImportedBooks() {
    return _database.fetchImportedBooks();
  }

  Future<ReadingOverview> getReadingOverview() {
    return _database.fetchReadingOverview();
  }

  Future<BookReaderPayload?> getReaderPayload({
    required String bookId,
    String? chapterId,
  }) {
    return _database.fetchReaderPayload(
      bookId: bookId,
      chapterId: chapterId,
    );
  }

  Future<Map<String, ReadingProgress>> getReadingProgressMap() {
    return _database.fetchAllReadingProgress();
  }

  Future<List<BookBookmark>> getBookmarks(String bookId) {
    return _database.fetchBookmarks(bookId);
  }

  Future<BookBookmark?> getBookmarkAtPosition({
    required String bookId,
    required String chapterId,
    required int pageIndex,
  }) {
    return _database.fetchBookmarkAtPosition(
      bookId: bookId,
      chapterId: chapterId,
      pageIndex: pageIndex,
    );
  }

  Future<void> saveBookmark({
    required String bookId,
    required String chapterId,
    required String chapterTitle,
    required int pageIndex,
    required double progress,
    required String excerpt,
  }) {
    return _database.saveBookmark(
      bookId: bookId,
      chapterId: chapterId,
      chapterTitle: chapterTitle,
      pageIndex: pageIndex,
      progress: progress,
      excerpt: excerpt,
    );
  }

  Future<void> deleteBookmark(int bookmarkId) {
    return _database.deleteBookmark(bookmarkId);
  }

  Future<void> importBooksByPaths(List<String> paths) async {
    final sources = paths
        .map(
          (path) => BookImportSource(
            name: path.split(Platform.pathSeparator).last,
            path: path,
          ),
        )
        .toList();
    await importBooks(sources);
  }

  Future<void> importBooks(List<BookImportSource> sources) async {
    _logger.info('开始导入书籍，数量=${sources.length}');

    for (final source in sources) {
      final normalizedName = source.name.trim();
      if (normalizedName.isEmpty) {
        _logger.info('跳过空文件名导入项');
        continue;
      }

      _logger.info(
        '导入项: name=${source.name}, ext=${source.extension}, hasPath=${source.path != null}, hasBytes=${source.bytes != null}, bytesLength=${source.bytes?.length ?? 0}',
      );

      if (source.extension == '.epub') {
        await _epubImporter.importIntoDatabase(
          source: source,
          database: _database,
        );
        continue;
      }

      if (source.extension == '.txt') {
        await _txtImporter.importIntoDatabase(
          source: source,
          database: _database,
        );
        continue;
      }

      throw UnsupportedError('不支持的文件类型: ${source.name}');
    }
  }

  Future<void> importBooksFromDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      throw FileSystemException('目录不存在', directoryPath);
    }

    final paths = await directory
        .list(recursive: true, followLinks: false)
        .where((entity) => entity is File)
        .map((entity) => entity.path)
        .where(
          (path) =>
              path.toLowerCase().endsWith('.txt') ||
              path.toLowerCase().endsWith('.epub'),
        )
        .toList();

    if (paths.isEmpty) {
      throw StateError('目录内没有可导入的 txt 或 epub 文件');
    }

    await importBooksByPaths(paths);
  }

  Future<void> updateBookMetadata({
    required String bookId,
    required String title,
    required String author,
  }) {
    return _database.updateBookMetadata(
      bookId: bookId,
      title: title,
      author: author,
    );
  }

  Future<void> deleteBook(String bookId) {
    return _database.deleteBook(bookId);
  }

  Future<void> recordReadingSession({
    required String bookId,
    required int readingSeconds,
    required double progress,
  }) {
    return _database.recordReadingSession(
      bookId: bookId,
      readingSeconds: readingSeconds,
      progress: progress,
    );
  }

  Future<void> saveReadingProgress({
    required String bookId,
    required double progress,
    required String? chapterId,
    required String chapterLabel,
    required int pageIndex,
  }) {
    return _database.upsertReadingProgress(
      bookId: bookId,
      progress: progress,
      chapterId: chapterId,
      chapterLabel: chapterLabel,
      pageIndex: pageIndex,
    );
  }
}
