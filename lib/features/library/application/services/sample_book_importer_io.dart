import 'dart:io';

import '../../../../data/local/db/app_database.dart';
import 'book_import_source.dart';
import 'txt_importer.dart';

Future<void> importBundledSampleIfExists(AppDatabase database) async {
  const samplePath = '0403 绿野仙踪  清  李百川.Txt';
  final file = File(samplePath);
  if (!await file.exists()) {
    return;
  }

  final importedBooks = await database.fetchImportedBooks();
  if (importedBooks.any((book) => book.id == '0403-绿野仙踪-清-李百川')) {
    return;
  }

  final importer = TxtImporter();
  await importer.importIntoDatabase(
    source: const BookImportSource(
      name: samplePath,
      path: samplePath,
    ),
    database: database,
  );
}
