import 'dart:io';

import 'package:path/path.dart' as p;

class BookImportSource {
  const BookImportSource({
    required this.name,
    this.path,
    this.bytes,
  }) : assert(
         path != null || bytes != null,
         '导入源必须提供路径或文件内容',
       );

  final String name;
  final String? path;
  final List<int>? bytes;

  String get extension => _pathContext.extension(name).toLowerCase();

  Future<List<int>> readBytes() async {
    if (bytes != null) {
      return bytes!;
    }
    return File(path!).readAsBytes();
  }

  static final _pathContext = p.Context();
}
