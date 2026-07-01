import 'dart:convert';
import 'dart:io';

import '../../../../data/local/db/app_database.dart';

class ImportedBookDraft {
  const ImportedBookDraft({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.title,
    required this.author,
    required this.chapterLabel,
    required this.description,
    required this.coverStartColor,
    required this.coverEndColor,
    required this.spineHeight,
    required this.chapters,
  });

  final String id;
  final String categoryId;
  final String categoryTitle;
  final String title;
  final String author;
  final String chapterLabel;
  final String description;
  final int coverStartColor;
  final int coverEndColor;
  final double spineHeight;
  final List<ImportedChapterDraft> chapters;
}

class ImportedChapterDraft {
  const ImportedChapterDraft({
    required this.id,
    required this.orderIndex,
    required this.title,
    required this.paragraphs,
  });

  final String id;
  final int orderIndex;
  final String title;
  final List<String> paragraphs;
}

class TxtImporter {
  Future<ImportedBookDraft> parseFile(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final text = _decode(bytes);
    final fileName = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : path.split(Platform.pathSeparator).last;

    final lines = text
        .split(RegExp(r'\r?\n'))
        .map(_normalizeLine)
        .where((line) => line.isNotEmpty)
        .toList();

    final metadata = _parseFileName(fileName);
    final cleanedLines = _removeHeaderNoise(lines);
    final chapterLines = cleanedLines
        .where((line) => _chapterPattern.hasMatch(line))
        .take(12)
        .toList();
    final bookId = _buildBookId(fileName);
    final chapters = _splitChapters(
      bookId: bookId,
      lines: cleanedLines,
    );
    final preview = chapterLines.isNotEmpty
        ? chapterLines.join(' / ')
        : cleanedLines.take(3).join(' / ');

    return ImportedBookDraft(
      id: bookId,
      categoryId: 'imported',
      categoryTitle: 'Imported',
      title: metadata.$1,
      author: metadata.$2,
      chapterLabel: chapters.isNotEmpty ? chapters.first.title : '正文',
      description: preview,
      coverStartColor: 0xFF4C6A92,
      coverEndColor: 0xFF1F2F47,
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

  String _decode(List<int> bytes) {
    try {
      return utf8.decode(bytes);
    } on FormatException {
      return systemEncoding.decode(bytes);
    }
  }

  (String, String) _parseFileName(String fileName) {
    final plainName = fileName.replaceAll(RegExp(r'\.[^.]+$'), '');
    final normalized = plainName.replaceAll(RegExp(r'\s+'), ' ').trim();
    final parts = normalized.split(' ');

    if (parts.length >= 4) {
      return (parts[1], parts.sublist(2).join(' '));
    }
    if (parts.length >= 2) {
      return (parts.first, parts.skip(1).join(' '));
    }

    return (normalized, '佚名');
  }

  List<String> _removeHeaderNoise(List<String> lines) {
    final result = <String>[];
    var skippedTitle = false;
    var skippedCatalog = false;

    for (final line in lines) {
      if (!skippedTitle) {
        skippedTitle = true;
        continue;
      }

      if (!skippedCatalog && line.contains('目录')) {
        skippedCatalog = true;
        continue;
      }

      result.add(line);
    }

    final firstChapterIndexes = <int>[];
    for (var index = 0; index < result.length; index += 1) {
      if (result[index].startsWith('第一回')) {
        firstChapterIndexes.add(index);
      }
    }

    if (firstChapterIndexes.length >= 2) {
      return result.sublist(firstChapterIndexes[1]);
    }

    return result;
  }

  String _normalizeLine(String raw) {
    return raw
        .replaceAll('\u3000', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _buildBookId(String fileName) {
    final plainName = fileName.replaceAll(RegExp(r'\.[^.]+$'), '');
    return plainName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\u4e00-\u9fa5]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  static final RegExp _chapterPattern =
      RegExp(r'^第[一二三四五六七八九十百千万〇零\d]+[回章节卷].*');

  List<ImportedChapterDraft> _splitChapters({
    required String bookId,
    required List<String> lines,
  }) {
    final chapters = <ImportedChapterDraft>[];
    String? currentTitle;
    var currentParagraphs = <String>[];
    var orderIndex = 0;

    void pushChapter() {
      if (currentTitle == null || currentParagraphs.isEmpty) {
        return;
      }

      chapters.add(
        ImportedChapterDraft(
          id: '$bookId-$orderIndex',
          orderIndex: orderIndex,
          title: currentTitle,
          paragraphs: List<String>.from(currentParagraphs),
        ),
      );
      orderIndex += 1;
      currentParagraphs = <String>[];
    }

    for (final line in lines) {
      if (_chapterPattern.hasMatch(line)) {
        pushChapter();
        currentTitle = line;
        continue;
      }

      currentParagraphs.add(line);
    }

    if (currentTitle == null) {
      return <ImportedChapterDraft>[
        ImportedChapterDraft(
          id: '$bookId-0',
          orderIndex: 0,
          title: '正文',
          paragraphs: lines,
        ),
      ];
    }

    pushChapter();
    return chapters;
  }
}
