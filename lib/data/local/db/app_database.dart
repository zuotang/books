import 'dart:convert';
import 'dart:ui';

import 'package:drift/drift.dart';

import '../../../features/library/domain/book_models.dart';
import '../../../features/library/application/services/txt_importer.dart';
import 'connection/connection.dart' as connection;
import 'seed_library.dart';
import 'tables/book_chapter_table.dart';
import 'tables/bookmark_table.dart';
import 'tables/book_table.dart';
import 'tables/category_table.dart';
import 'tables/reading_progress_table.dart';
import 'tables/reading_stats_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CategoryTable,
    BookTable,
    BookChapterTable,
    ReadingProgressTable,
    BookmarkTable,
    ReadingStatsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? connection.openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            // v2 起把正文从 book_table 拆到章节表，开发期直接重建相关表。
            await customStatement('DROP TABLE IF EXISTS reading_progress_table;');
            await customStatement('DROP TABLE IF EXISTS bookmark_table;');
            await customStatement('DROP TABLE IF EXISTS book_chapter_table;');
            await customStatement('DROP TABLE IF EXISTS book_table;');
            await customStatement('DROP TABLE IF EXISTS category_table;');

            await migrator.createTable(categoryTable);
            await migrator.createTable(bookTable);
            await migrator.createTable(bookChapterTable);
            await migrator.createTable(readingProgressTable);
          }
          if (from < 3) {
            await migrator.createTable(bookmarkTable);
          }
          if (from < 4) {
            await migrator.createTable(readingStatsTable);
          }
        },
      );

  Future<void> ensureCompatibleSchema() async {
    final bookTableInfo =
        await customSelect("PRAGMA table_info('book_table')").get();
    final hasLegacyBodyJson = bookTableInfo.any(
      (row) => row.data['name'] == 'body_json',
    );

    final chapterTableInfo =
        await customSelect("PRAGMA table_info('book_chapter_table')").get();
    final hasChapterTable = chapterTableInfo.isNotEmpty;
    final bookmarkTableInfo =
        await customSelect("PRAGMA table_info('bookmark_table')").get();
    final hasBookmarkTable = bookmarkTableInfo.isNotEmpty;
    final readingStatsTableInfo =
        await customSelect("PRAGMA table_info('reading_stats_table')").get();
    final hasReadingStatsTable = readingStatsTableInfo.isNotEmpty;

    if (!hasLegacyBodyJson &&
        hasChapterTable &&
        hasBookmarkTable &&
        hasReadingStatsTable) {
      return;
    }

    await transaction(() async {
      await customStatement('DROP TABLE IF EXISTS reading_progress_table;');
      await customStatement('DROP TABLE IF EXISTS reading_stats_table;');
      await customStatement('DROP TABLE IF EXISTS bookmark_table;');
      await customStatement('DROP TABLE IF EXISTS book_chapter_table;');
      await customStatement('DROP TABLE IF EXISTS book_table;');
      await customStatement('DROP TABLE IF EXISTS category_table;');

      await customStatement('''
        CREATE TABLE category_table (
          id TEXT NOT NULL PRIMARY KEY,
          title TEXT NOT NULL
        );
      ''');

      await customStatement('''
        CREATE TABLE book_table (
          id TEXT NOT NULL PRIMARY KEY,
          category_id TEXT NOT NULL REFERENCES category_table (id),
          title TEXT NOT NULL,
          author TEXT NOT NULL,
          chapter_label TEXT NOT NULL,
          description TEXT NOT NULL,
          cover_start_color INTEGER NOT NULL,
          cover_end_color INTEGER NOT NULL,
          spine_height REAL NOT NULL
        );
      ''');

      await customStatement('''
        CREATE TABLE book_chapter_table (
          id TEXT NOT NULL PRIMARY KEY,
          book_id TEXT NOT NULL REFERENCES book_table (id),
          order_index INTEGER NOT NULL,
          title TEXT NOT NULL,
          paragraphs_json TEXT NOT NULL
        );
      ''');

      await customStatement('''
        CREATE TABLE reading_progress_table (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          book_id TEXT NOT NULL UNIQUE REFERENCES book_table (id),
          progress REAL NOT NULL DEFAULT 0,
          chapter_id TEXT NULL,
          chapter_label TEXT NULL,
          page_index INTEGER NOT NULL DEFAULT 0,
          updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
      ''');

      await customStatement('''
        CREATE TABLE bookmark_table (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          book_id TEXT NOT NULL REFERENCES book_table (id),
          chapter_id TEXT NOT NULL REFERENCES book_chapter_table (id),
          chapter_title TEXT NOT NULL,
          page_index INTEGER NOT NULL,
          progress REAL NOT NULL DEFAULT 0,
          excerpt TEXT NOT NULL,
          created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
          UNIQUE(book_id, chapter_id, page_index)
        );
      ''');

      await customStatement('''
        CREATE TABLE reading_stats_table (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          book_id TEXT NOT NULL UNIQUE REFERENCES book_table (id),
          total_reading_seconds INTEGER NOT NULL DEFAULT 0,
          session_count INTEGER NOT NULL DEFAULT 0,
          last_progress REAL NOT NULL DEFAULT 0,
          last_read_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
      ''');
    });
  }

  Future<void> seedDemoLibraryIfNeeded() async {
    final existing = await (select(bookTable)..limit(1)).getSingleOrNull();
    if (existing != null) {
      return;
    }

    final seededCategories = seedLibrary
        .map(
          (category) => CategoryTableCompanion.insert(
            id: category.id,
            title: category.title,
          ),
        )
        .toList();
    final seededBooks = <BookTableCompanion>[];
    for (final category in seedLibrary) {
      for (final book in category.books) {
        seededBooks.add(
          BookTableCompanion.insert(
            id: book.id,
            categoryId: category.id,
            title: book.title,
            author: book.author,
            chapterLabel: book.chapterLabel,
            description: book.description,
            coverStartColor: book.coverStartColor.toARGB32(),
            coverEndColor: book.coverEndColor.toARGB32(),
            spineHeight: book.spineHeight,
          ),
        );
      }
    }
    final seededChapters = <BookChapterTableCompanion>[];
    for (final category in seedLibrary) {
      for (final book in category.books) {
        seededChapters.add(
          BookChapterTableCompanion.insert(
            id: '${book.id}-0',
            bookId: book.id,
            orderIndex: 0,
            title: book.chapterLabel,
            paragraphsJson: jsonEncode(book.body),
          ),
        );
      }
    }

    await batch((batch) {
      batch.insertAll(categoryTable, seededCategories);
      batch.insertAll(bookTable, seededBooks);
      batch.insertAll(bookChapterTable, seededChapters);
    });
  }

  Future<List<BookCategory>> fetchCategoriesWithBooks() async {
    final categoryRows = await select(categoryTable).get();
    final bookRows = await select(bookTable).get();

    return categoryRows.map((category) {
      final booksInCategory = bookRows
          .where((book) => book.categoryId == category.id)
          .map(_mapBook)
          .toList();

      return BookCategory(
        id: category.id,
        title: category.title,
        books: booksInCategory,
      );
    }).toList();
  }

  Future<BookCategory?> fetchCategory(String categoryId) async {
    final categoryRow = await (select(categoryTable)
          ..where((table) => table.id.equals(categoryId)))
        .getSingleOrNull();
    if (categoryRow == null) {
      return null;
    }

    final bookRows = await (select(bookTable)
          ..where((table) => table.categoryId.equals(categoryId)))
        .get();

    return BookCategory(
      id: categoryRow.id,
      title: categoryRow.title,
      books: bookRows.map(_mapBook).toList(),
    );
  }

  Future<Book?> fetchBook(String bookId) async {
    final bookRow =
        await (select(bookTable)..where((table) => table.id.equals(bookId)))
            .getSingleOrNull();
    return bookRow == null ? null : _mapBook(bookRow);
  }

  Future<List<Book>> fetchImportedBooks() async {
    final rows = await (select(bookTable)
          ..where((table) => table.categoryId.equals('imported')))
        .get();
    return rows.map(_mapBook).toList();
  }

  Future<List<BookChapter>> fetchChapters(String bookId) async {
    final rows = await (select(bookChapterTable)
          ..where((table) => table.bookId.equals(bookId))
          ..orderBy([
            (table) => OrderingTerm.asc(table.orderIndex),
          ]))
        .get();

    return rows.map(_mapChapter).toList();
  }

  Future<BookReaderPayload?> fetchReaderPayload({
    required String bookId,
    String? chapterId,
  }) async {
    final book = await fetchBook(bookId);
    if (book == null) {
      return null;
    }

    final chapters = await fetchChapters(bookId);
    if (chapters.isEmpty) {
      return null;
    }

    final progress = await fetchReadingProgress(bookId);
    final currentChapter = chapterId == null
        ? chapters.firstWhere(
            (chapter) => chapter.id == progress?.chapterId,
            orElse: () => chapters.first,
          )
        : chapters.firstWhere(
            (chapter) => chapter.id == chapterId,
            orElse: () => chapters.first,
          );

    return BookReaderPayload(
      book: book,
      chapters: chapters,
      currentChapter: currentChapter,
      initialPageIndex:
          currentChapter.id == progress?.chapterId ? progress!.pageIndex : 0,
    );
  }

  Future<ReadingProgress?> fetchReadingProgress(String bookId) async {
    final row = await (select(readingProgressTable)
          ..where((table) => table.bookId.equals(bookId)))
        .getSingleOrNull();
    if (row == null) {
      return null;
    }

    return ReadingProgress(
      bookId: row.bookId,
      chapterId: row.chapterId,
      chapterLabel: row.chapterLabel,
      pageIndex: row.pageIndex,
      progress: row.progress,
      updatedAt: row.updatedAt,
    );
  }

  Future<Map<String, ReadingProgress>> fetchAllReadingProgress() async {
    final rows = await select(readingProgressTable).get();

    return Map<String, ReadingProgress>.fromEntries(
      rows.map(
        (row) => MapEntry(
          row.bookId,
          ReadingProgress(
            bookId: row.bookId,
            chapterId: row.chapterId,
            chapterLabel: row.chapterLabel,
            pageIndex: row.pageIndex,
            progress: row.progress,
            updatedAt: row.updatedAt,
          ),
        ),
      ),
    );
  }

  Future<void> upsertReadingProgress({
    required String bookId,
    required double progress,
    required String? chapterId,
    required String chapterLabel,
    required int pageIndex,
  }) {
    final companion = ReadingProgressTableCompanion.insert(
      bookId: bookId,
      progress: Value(progress),
      chapterId: Value(chapterId),
      chapterLabel: Value(chapterLabel),
      pageIndex: Value(pageIndex),
      updatedAt: Value(DateTime.now()),
    );

    return into(readingProgressTable).insert(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: <Column<Object>>[readingProgressTable.bookId],
      ),
    );
  }

  Future<List<BookBookmark>> fetchBookmarks(String bookId) async {
    final rows = await (select(bookmarkTable)
          ..where((table) => table.bookId.equals(bookId))
          ..orderBy([
            (table) => OrderingTerm.desc(table.createdAt),
          ]))
        .get();

    return rows.map(_mapBookmark).toList();
  }

  Future<BookBookmark?> fetchBookmarkAtPosition({
    required String bookId,
    required String chapterId,
    required int pageIndex,
  }) async {
    final row = await (select(bookmarkTable)
          ..where((table) => table.bookId.equals(bookId))
          ..where((table) => table.chapterId.equals(chapterId))
          ..where((table) => table.pageIndex.equals(pageIndex)))
        .getSingleOrNull();

    return row == null ? null : _mapBookmark(row);
  }

  Future<void> saveBookmark({
    required String bookId,
    required String chapterId,
    required String chapterTitle,
    required int pageIndex,
    required double progress,
    required String excerpt,
  }) {
    final companion = BookmarkTableCompanion.insert(
      bookId: bookId,
      chapterId: chapterId,
      chapterTitle: chapterTitle,
      pageIndex: pageIndex,
      progress: Value(progress),
      excerpt: excerpt,
      createdAt: Value(DateTime.now()),
    );

    return into(bookmarkTable).insert(
      companion,
      onConflict: DoUpdate(
        (old) => companion,
        target: <Column<Object>>[
          bookmarkTable.bookId,
          bookmarkTable.chapterId,
          bookmarkTable.pageIndex,
        ],
      ),
    );
  }

  Future<void> deleteBookmark(int bookmarkId) {
    return (delete(bookmarkTable)..where((table) => table.id.equals(bookmarkId)))
        .go();
  }

  Future<void> updateBookMetadata({
    required String bookId,
    required String title,
    required String author,
  }) {
    return (update(bookTable)..where((table) => table.id.equals(bookId))).write(
      BookTableCompanion(
        title: Value(title),
        author: Value(author),
      ),
    );
  }

  Future<void> deleteBook(String bookId) {
    return transaction(() async {
      await (delete(bookmarkTable)..where((table) => table.bookId.equals(bookId)))
          .go();
      await (delete(readingStatsTable)
            ..where((table) => table.bookId.equals(bookId)))
          .go();
      await (delete(readingProgressTable)
            ..where((table) => table.bookId.equals(bookId)))
          .go();
      await (delete(bookChapterTable)..where((table) => table.bookId.equals(bookId)))
          .go();
      await (delete(bookTable)..where((table) => table.id.equals(bookId))).go();

      final importedCount = await (selectOnly(categoryTable)
            ..addColumns([categoryTable.id.count()])
            ..where(categoryTable.id.equals('imported')))
          .map((row) => row.read(categoryTable.id.count()) ?? 0)
          .getSingle();

      if (importedCount > 0) {
        final bookCount = await (selectOnly(bookTable)
              ..addColumns([bookTable.id.count()])
              ..where(bookTable.categoryId.equals('imported')))
            .map((row) => row.read(bookTable.id.count()) ?? 0)
            .getSingle();

        if (bookCount == 0) {
          await (delete(categoryTable)..where((table) => table.id.equals('imported')))
              .go();
        }
      }
    });
  }

  Future<void> upsertImportedBook(ImportedBookDraft draft) async {
    await into(categoryTable).insertOnConflictUpdate(
      CategoryTableCompanion.insert(
        id: draft.categoryId,
        title: draft.categoryTitle,
      ),
    );

    await into(bookTable).insertOnConflictUpdate(
      BookTableCompanion.insert(
        id: draft.id,
        categoryId: draft.categoryId,
        title: draft.title,
        author: draft.author,
        chapterLabel: draft.chapterLabel,
        description: draft.description,
        coverStartColor: draft.coverStartColor,
        coverEndColor: draft.coverEndColor,
        spineHeight: draft.spineHeight,
      ),
    );

    await batch((batch) async {
      await (delete(bookChapterTable)
            ..where((table) => table.bookId.equals(draft.id)))
          .go();

      batch.insertAll(
        bookChapterTable,
        draft.chapters
            .map(
              (chapter) => BookChapterTableCompanion.insert(
                id: chapter.id,
                bookId: draft.id,
                orderIndex: chapter.orderIndex,
                title: chapter.title,
                paragraphsJson: jsonEncode(chapter.paragraphs),
              ),
            )
            .toList(),
      );
    });
  }

  Book _mapBook(DbBook row) {
    return Book(
      id: row.id,
      title: row.title,
      author: row.author,
      chapterLabel: row.chapterLabel,
      description: row.description,
      coverColors: <Color>[
        Color(row.coverStartColor),
        Color(row.coverEndColor),
      ],
      spineHeight: row.spineHeight,
    );
  }

  BookChapter _mapChapter(DbBookChapter row) {
    return BookChapter(
      id: row.id,
      bookId: row.bookId,
      orderIndex: row.orderIndex,
      title: row.title,
      paragraphs: (jsonDecode(row.paragraphsJson) as List<dynamic>)
          .map((value) => value.toString())
          .toList(),
    );
  }

  BookBookmark _mapBookmark(DbBookmarkEntry row) {
    return BookBookmark(
      id: row.id,
      bookId: row.bookId,
      chapterId: row.chapterId,
      chapterTitle: row.chapterTitle,
      pageIndex: row.pageIndex,
      progress: row.progress,
      excerpt: row.excerpt,
      createdAt: row.createdAt,
    );
  }

  Future<void> recordReadingSession({
    required String bookId,
    required int readingSeconds,
    required double progress,
  }) async {
    if (readingSeconds <= 0) {
      return;
    }

    final existing = await (select(readingStatsTable)
          ..where((table) => table.bookId.equals(bookId)))
        .getSingleOrNull();

    if (existing == null) {
      await into(readingStatsTable).insert(
        ReadingStatsTableCompanion.insert(
          bookId: bookId,
          totalReadingSeconds: Value(readingSeconds),
          sessionCount: const Value(1),
          lastProgress: Value(progress),
          lastReadAt: Value(DateTime.now()),
        ),
      );
      return;
    }

    await (update(readingStatsTable)
          ..where((table) => table.bookId.equals(bookId)))
        .write(
      ReadingStatsTableCompanion(
        totalReadingSeconds:
            Value(existing.totalReadingSeconds + readingSeconds),
        sessionCount: Value(existing.sessionCount + 1),
        lastProgress: Value(progress),
        lastReadAt: Value(DateTime.now()),
      ),
    );
  }

  Future<ReadingOverview> fetchReadingOverview() async {
    final rows = await select(readingStatsTable).get();
    final totalSeconds = rows.fold<int>(
      0,
      (sum, row) => sum + row.totalReadingSeconds.toInt(),
    );
    final lastReadAt = rows.isEmpty
        ? null
        : rows
            .map((row) => row.lastReadAt)
            .reduce((left, right) => left.isAfter(right) ? left : right);

    return ReadingOverview(
      totalBooksStarted: rows.length,
      totalReadingSeconds: totalSeconds,
      lastReadAt: lastReadAt,
    );
  }
}
