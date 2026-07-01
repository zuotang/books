import 'package:drift/drift.dart';

import 'book_table.dart';

@DataClassName('DbReadingProgressEntry')
class ReadingProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookId => text().references(BookTable, #id).unique()();
  RealColumn get progress => real().withDefault(const Constant(0))();
  TextColumn get chapterId => text().nullable()();
  TextColumn get chapterLabel => text().nullable()();
  IntColumn get pageIndex => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
