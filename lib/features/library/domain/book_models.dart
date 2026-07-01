import 'package:flutter/material.dart';

class BookCategory {
  const BookCategory({
    required this.id,
    required this.title,
    required this.books,
  });

  final String id;
  final String title;
  final List<Book> books;
}

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.chapterLabel,
    required this.description,
    required this.coverColors,
    required this.spineHeight,
  });

  final String id;
  final String title;
  final String author;
  final String chapterLabel;
  final String description;
  final List<Color> coverColors;
  final double spineHeight;
}

class BookChapter {
  const BookChapter({
    required this.id,
    required this.bookId,
    required this.orderIndex,
    required this.title,
    required this.paragraphs,
  });

  final String id;
  final String bookId;
  final int orderIndex;
  final String title;
  final List<String> paragraphs;
}

class BookReaderPayload {
  const BookReaderPayload({
    required this.book,
    required this.chapters,
    required this.currentChapter,
    required this.initialPageIndex,
  });

  final Book book;
  final List<BookChapter> chapters;
  final BookChapter currentChapter;
  final int initialPageIndex;
}

class ReadingProgress {
  const ReadingProgress({
    required this.bookId,
    required this.chapterId,
    required this.chapterLabel,
    required this.pageIndex,
    required this.progress,
    required this.updatedAt,
  });

  final String bookId;
  final String? chapterId;
  final String? chapterLabel;
  final int pageIndex;
  final double progress;
  final DateTime updatedAt;
}

class BookBookmark {
  const BookBookmark({
    required this.id,
    required this.bookId,
    required this.chapterId,
    required this.chapterTitle,
    required this.pageIndex,
    required this.progress,
    required this.excerpt,
    required this.createdAt,
  });

  final int id;
  final String bookId;
  final String chapterId;
  final String chapterTitle;
  final int pageIndex;
  final double progress;
  final String excerpt;
  final DateTime createdAt;
}

class BookReadingStats {
  const BookReadingStats({
    required this.bookId,
    required this.totalReadingSeconds,
    required this.sessionCount,
    required this.lastProgress,
    required this.lastReadAt,
  });

  final String bookId;
  final int totalReadingSeconds;
  final int sessionCount;
  final double lastProgress;
  final DateTime lastReadAt;
}

class ReadingOverview {
  const ReadingOverview({
    required this.totalBooksStarted,
    required this.totalReadingSeconds,
    required this.lastReadAt,
  });

  final int totalBooksStarted;
  final int totalReadingSeconds;
  final DateTime? lastReadAt;
}
