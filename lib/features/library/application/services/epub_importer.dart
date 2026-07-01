import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

import '../../../../data/local/db/app_database.dart';
import 'txt_importer.dart';

class EpubImporter {
  Future<ImportedBookDraft> parseFile(String filePath) async {
    final bytes = await File(filePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final containerXml = _readArchiveText(archive, 'META-INF/container.xml');
    final containerDoc = XmlDocument.parse(containerXml);
    final rootfilePath = containerDoc
        .findAllElements('rootfile')
        .map((node) => node.getAttribute('full-path'))
        .whereType<String>()
        .first;

    final packageXml = _readArchiveText(archive, rootfilePath);
    final packageDoc = XmlDocument.parse(packageXml);
    final packageDir = path.posix.dirname(rootfilePath);

    final metadataNode = packageDoc.findAllElements('metadata').first;
    final manifestNode = packageDoc.findAllElements('manifest').first;
    final spineNode = packageDoc.findAllElements('spine').first;

    final title = _firstText(
          metadataNode,
          <String>['dc:title', 'title'],
        ) ??
        path.basenameWithoutExtension(filePath);
    final author =
        _firstText(metadataNode, <String>['dc:creator', 'creator']) ?? 'Unknown';

    final manifest = <String, String>{};
    for (final item in manifestNode.findElements('item')) {
      final id = item.getAttribute('id');
      final href = item.getAttribute('href');
      if (id != null && href != null) {
        manifest[id] = path.posix.normalize(path.posix.join(packageDir, href));
      }
    }

    final bookId = _buildBookId(filePath);
    final chapters = <ImportedChapterDraft>[];
    var orderIndex = 0;

    for (final itemRef in spineNode.findElements('itemref')) {
      final idref = itemRef.getAttribute('idref');
      final chapterPath = idref == null ? null : manifest[idref];
      if (chapterPath == null) {
        continue;
      }

      final chapterXml = _readArchiveText(archive, chapterPath);
      final chapterDoc = XmlDocument.parse(chapterXml);
      final titleNode = _firstText(
        chapterDoc.rootElement,
        <String>['title', 'h1', 'h2'],
      );
      final paragraphs = _extractParagraphs(chapterDoc);
      if (paragraphs.isEmpty) {
        continue;
      }

      chapters.add(
        ImportedChapterDraft(
          id: '$bookId-$orderIndex',
          orderIndex: orderIndex,
          title: (titleNode == null || titleNode.trim().isEmpty)
              ? 'Chapter ${orderIndex + 1}'
              : titleNode.trim(),
          paragraphs: paragraphs,
        ),
      );
      orderIndex += 1;
    }

    if (chapters.isEmpty) {
      throw StateError('未解析到有效章节');
    }

    return ImportedBookDraft(
      id: bookId,
      categoryId: 'imported',
      categoryTitle: 'Imported',
      title: title.trim(),
      author: author.trim(),
      chapterLabel: chapters.first.title,
      description: chapters.take(3).map((chapter) => chapter.title).join(' / '),
      coverStartColor: 0xFF5D83B5,
      coverEndColor: 0xFF243958,
      spineHeight: 132,
      chapters: chapters,
    );
  }

  Future<void> importIntoDatabase({
    required String path,
    required AppDatabase database,
  }) async {
    final draft = await parseFile(path);
    await database.upsertImportedBook(draft);
  }

  String _readArchiveText(Archive archive, String name) {
    final file = archive.findFile(name);
    if (file == null) {
      throw StateError('EPUB 文件缺少 $name');
    }
    return utf8.decode(file.content as List<int>);
  }

  List<String> _extractParagraphs(XmlDocument document) {
    final paragraphs = document
        .findAllElements('p')
        .map((node) => _normalizeText(node.innerText))
        .where((value) => value.isNotEmpty)
        .toList();

    if (paragraphs.isNotEmpty) {
      return paragraphs;
    }

    final bodyTexts = document
        .findAllElements('body')
        .expand((node) => node.descendants)
        .whereType<XmlText>()
        .map((node) => _normalizeText(node.value))
        .where((value) => value.isNotEmpty)
        .toList();
    return bodyTexts;
  }

  String? _firstText(XmlNode node, List<String> tagNames) {
    for (final tagName in tagNames) {
      final match = node.findAllElements(tagName).firstOrNull;
      if (match != null && match.innerText.trim().isNotEmpty) {
        return match.innerText.trim();
      }
    }
    return null;
  }

  String _normalizeText(String raw) {
    return raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _buildBookId(String filePath) {
    final plainName = path.basenameWithoutExtension(filePath);
    return plainName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\u4e00-\u9fa5]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
