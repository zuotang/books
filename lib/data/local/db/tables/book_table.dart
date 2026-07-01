import 'package:drift/drift.dart';

import 'category_table.dart';

@DataClassName('DbBook')
class BookTable extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(CategoryTable, #id)();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get chapterLabel => text()();
  TextColumn get description => text()();
  IntColumn get coverStartColor => integer()();
  IntColumn get coverEndColor => integer()();
  RealColumn get spineHeight => real()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
