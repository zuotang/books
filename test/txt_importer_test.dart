import 'dart:io';

import 'package:archive/archive.dart';
import 'package:book_app/features/library/application/services/book_import_source.dart';
import 'package:book_app/features/library/application/services/epub_importer.dart';
import 'package:book_app/features/library/application/services/txt_importer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GBK 古籍文本可解析为导入草稿', () async {
    final importer = TxtImporter();

    final bytes = await File('0403 绿野仙踪  清  李百川.Txt').readAsBytes();
    final draft = await importer.parseSource(
      BookImportSource(
        name: '0403 绿野仙踪  清  李百川.Txt',
        bytes: bytes,
      ),
    );

    expect(draft.title, '绿野仙踪');
    expect(draft.author, contains('李百川'));
    expect(draft.chapterLabel, startsWith('第一回'));
    expect(draft.chapters, isNotEmpty);
    expect(draft.chapters.first.title, startsWith('第一回'));
    expect(draft.chapters.first.paragraphs, isNotEmpty);
    expect(draft.chapters.length, greaterThan(50));
  });

  test('EPUB 可解析为导入草稿', () async {
    final importer = EpubImporter();
    final tempDir = await Directory.systemTemp.createTemp('epub_import_test');
    addTearDown(() => tempDir.delete(recursive: true));
    final epubFile = File('${tempDir.path}/sample.epub');

    final archive = Archive()
      ..addFile(
        ArchiveFile.string(
          'META-INF/container.xml',
          '''
<?xml version="1.0" encoding="UTF-8"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>
''',
        ),
      )
      ..addFile(
        ArchiveFile.string(
          'OEBPS/content.opf',
          '''
<?xml version="1.0" encoding="UTF-8"?>
<package version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <metadata>
    <dc:title>Sample EPUB</dc:title>
    <dc:creator>Tester</dc:creator>
  </metadata>
  <manifest>
    <item id="c1" href="chapter1.xhtml" media-type="application/xhtml+xml"/>
    <item id="c2" href="chapter2.xhtml" media-type="application/xhtml+xml"/>
  </manifest>
  <spine>
    <itemref idref="c1"/>
    <itemref idref="c2"/>
  </spine>
</package>
''',
        ),
      )
      ..addFile(
        ArchiveFile.string(
          'OEBPS/chapter1.xhtml',
          '''
<html>
  <head><title>Chapter 1</title></head>
  <body>
    <h1>Chapter 1</h1>
    <p>First paragraph.</p>
    <p>Second paragraph.</p>
  </body>
</html>
''',
        ),
      )
      ..addFile(
        ArchiveFile.string(
          'OEBPS/chapter2.xhtml',
          '''
<html>
  <head><title>Chapter 2</title></head>
  <body>
    <h1>Chapter 2</h1>
    <p>Third paragraph.</p>
  </body>
</html>
''',
        ),
      );

    await epubFile.writeAsBytes(ZipEncoder().encode(archive));
    final draft = await importer.parseSource(
      BookImportSource(
        name: 'sample.epub',
        bytes: await epubFile.readAsBytes(),
      ),
    );

    expect(draft.title, 'Sample EPUB');
    expect(draft.author, 'Tester');
    expect(draft.chapters, hasLength(2));
    expect(draft.chapters.first.title, 'Chapter 1');
    expect(draft.chapters.first.paragraphs.first, 'First paragraph.');
  });
}
