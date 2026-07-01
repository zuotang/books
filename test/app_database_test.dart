import 'package:book_app/data/local/db/app_database.dart';
import 'package:book_app/features/library/application/services/txt_importer.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('数据库种子数据可生成书库分类', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.seedDemoLibraryIfNeeded();
    final categories = await database.fetchCategoriesWithBooks();

    expect(categories, isNotEmpty);
    expect(categories.first.books, isNotEmpty);
    expect(await database.fetchBook('design-everyday'), isNotNull);
    expect(await database.fetchChapters('design-everyday'), isNotEmpty);
  });

  test('阅读进度可保存并恢复到章节和页码', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.seedDemoLibraryIfNeeded();
    await database.upsertReadingProgress(
      bookId: 'design-everyday',
      progress: 0.42,
      chapterId: 'design-everyday-0',
      chapterLabel: 'Chapter 1',
      pageIndex: 3,
    );

    final progress = await database.fetchReadingProgress('design-everyday');
    final payload = await database.fetchReaderPayload(bookId: 'design-everyday');
    final reopened = await database.fetchReaderPayload(bookId: 'design-everyday');

    expect(progress, isNotNull);
    expect(progress!.chapterId, 'design-everyday-0');
    expect(progress.pageIndex, 3);
    expect(payload, isNotNull);
    expect(payload!.initialPageIndex, 3);
    expect(payload.currentChapter.id, 'design-everyday-0');
    expect(reopened, isNotNull);
    expect(reopened!.initialPageIndex, 3);
    expect(reopened.currentChapter.id, 'design-everyday-0');
  });

  test('书签可保存查询并删除', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.seedDemoLibraryIfNeeded();
    await database.saveBookmark(
      bookId: 'design-everyday',
      chapterId: 'design-everyday-0',
      chapterTitle: 'Chapter 1',
      pageIndex: 2,
      progress: 0.25,
      excerpt: 'A useful excerpt',
    );

    final current = await database.fetchBookmarkAtPosition(
      bookId: 'design-everyday',
      chapterId: 'design-everyday-0',
      pageIndex: 2,
    );
    final list = await database.fetchBookmarks('design-everyday');

    expect(current, isNotNull);
    expect(current!.excerpt, 'A useful excerpt');
    expect(list, hasLength(1));

    await database.deleteBookmark(current.id);
    expect(await database.fetchBookmarks('design-everyday'), isEmpty);
  });

  test('导入图书可更新元数据并删除', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.seedDemoLibraryIfNeeded();
    await database.upsertImportedBook(
      const ImportedBookDraft(
        id: 'imported-book',
        categoryId: 'imported',
        categoryTitle: 'Imported',
        title: 'Old Title',
        author: 'Old Author',
        chapterLabel: '正文',
        description: 'desc',
        coverStartColor: 0xFF4C6A92,
        coverEndColor: 0xFF1F2F47,
        spineHeight: 132,
        chapters: <ImportedChapterDraft>[
          ImportedChapterDraft(
            id: 'imported-book-0',
            orderIndex: 0,
            title: '正文',
            paragraphs: <String>['abc'],
          ),
        ],
      ),
    );

    await database.updateBookMetadata(
      bookId: 'imported-book',
      title: 'New Title',
      author: 'New Author',
    );

    final book = await database.fetchBook('imported-book');
    expect(book, isNotNull);
    expect(book!.title, 'New Title');
    expect(book.author, 'New Author');

    await database.deleteBook('imported-book');
    expect(await database.fetchBook('imported-book'), isNull);
  });

  test('阅读统计可累计阅读时长', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.seedDemoLibraryIfNeeded();
    await database.recordReadingSession(
      bookId: 'design-everyday',
      readingSeconds: 120,
      progress: 0.3,
    );
    await database.recordReadingSession(
      bookId: 'design-everyday',
      readingSeconds: 180,
      progress: 0.6,
    );

    final overview = await database.fetchReadingOverview();

    expect(overview.totalBooksStarted, 1);
    expect(overview.totalReadingSeconds, 300);
    expect(overview.lastReadAt, isNotNull);
  });
}
