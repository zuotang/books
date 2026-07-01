import 'package:drift/drift.dart';

import 'book_table.dart';

@DataClassName('DbReadingStatsEntry')
class ReadingStatsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookId => text().references(BookTable, #id).unique()();
  IntColumn get totalReadingSeconds => integer().withDefault(const Constant(0))();
  IntColumn get sessionCount => integer().withDefault(const Constant(0))();
  RealColumn get lastProgress => real().withDefault(const Constant(0))();
  DateTimeColumn get lastReadAt => dateTime().withDefault(currentDateAndTime)();
}
