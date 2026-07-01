import 'package:drift/drift.dart';

import 'book_chapter_table.dart';
import 'book_table.dart';

@DataClassName('DbBookmarkEntry')
class BookmarkTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookId => text().references(BookTable, #id)();
  TextColumn get chapterId => text().references(BookChapterTable, #id)();
  TextColumn get chapterTitle => text()();
  IntColumn get pageIndex => integer()();
  RealColumn get progress => real().withDefault(const Constant(0))();
  TextColumn get excerpt => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
        <Column<Object>>{bookId, chapterId, pageIndex},
      ];
}
