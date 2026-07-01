import 'package:drift/drift.dart';

import 'book_table.dart';

@DataClassName('DbBookChapter')
class BookChapterTable extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text().references(BookTable, #id)();
  IntColumn get orderIndex => integer()();
  TextColumn get title => text()();
  TextColumn get paragraphsJson => text()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
