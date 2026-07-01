import '../../../../data/local/db/app_database.dart';
import 'sample_book_importer_stub.dart'
    if (dart.library.io) 'sample_book_importer_io.dart' as impl;

Future<void> importBundledSampleIfExists(AppDatabase database) {
  return impl.importBundledSampleIfExists(database);
}
