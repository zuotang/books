import 'package:drift/drift.dart';

@DataClassName('DbCategory')
class CategoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
