import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/db/app_database.dart';
import '../../../data/local/db/app_database_provider.dart';
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
  const BookRepository(this._database);

  final AppDatabase _database;
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
    for (final path in paths) {
      final normalized = path.trim();
      if (normalized.isEmpty) {
        continue;
      }
      if (normalized.toLowerCase().endsWith('.epub')) {
        await _epubImporter.importIntoDatabase(
          path: normalized,
          database: _database,
        );
      } else {
        await _txtImporter.importIntoDatabase(
          path: normalized,
          database: _database,
        );
      }
    }
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
