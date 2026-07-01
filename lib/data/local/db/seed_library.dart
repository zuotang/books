import 'package:flutter/material.dart';

class SeedCategory {
  const SeedCategory({
    required this.id,
    required this.title,
    required this.books,
  });

  final String id;
  final String title;
  final List<SeedBook> books;
}

class SeedBook {
  const SeedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.chapterLabel,
    required this.description,
    required this.coverStartColor,
    required this.coverEndColor,
    required this.spineHeight,
    required this.body,
  });

  final String id;
  final String title;
  final String author;
  final String chapterLabel;
  final String description;
  final Color coverStartColor;
  final Color coverEndColor;
  final double spineHeight;
  final List<String> body;
}

const List<String> _sharedBody = <String>[
  'Signifiers are often more useful than raw affordances when people are reading on screens. A well-shaped interface tells the reader what can be touched, what can be saved, and what can quietly fade into the background.',
  'A good reading app should stay calm. The library invites browsing, the collection view supports comparison, and the reader keeps attention on the text instead of the chrome around it.',
  'The best reading experiences make progress visible, settings reversible, and gestures forgiving. Readers should never feel punished for exploration.',
  'Design for reading means designing for rhythm. The transitions between discovery, selection, and immersion should feel natural, soft, and almost physical.',
];

const List<SeedCategory> seedLibrary = <SeedCategory>[
  SeedCategory(
    id: 'design',
    title: 'Design',
    books: <SeedBook>[
      SeedBook(
        id: 'design-everyday',
        title: 'The Design of Everyday Things',
        author: 'Don Norman',
        chapterLabel: 'Chapter 1',
        description: '让交互更清晰的设计原则',
        coverStartColor: Color(0xFFD3A257),
        coverEndColor: Color(0xFF7B4726),
        spineHeight: 126,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'visual-systems',
        title: 'Visual Systems',
        author: 'Maya Lin',
        chapterLabel: 'Chapter 3',
        description: '关于秩序、留白与视觉层级',
        coverStartColor: Color(0xFF6887D9),
        coverEndColor: Color(0xFF24345E),
        spineHeight: 116,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'modern-layout',
        title: 'Modern Layout',
        author: 'Elena Hart',
        chapterLabel: 'Chapter 2',
        description: '面向屏幕的版式结构',
        coverStartColor: Color(0xFFE0D5C4),
        coverEndColor: Color(0xFF9A7A59),
        spineHeight: 122,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'quiet-interfaces',
        title: 'Quiet Interfaces',
        author: 'Ari Cole',
        chapterLabel: 'Chapter 4',
        description: '低打扰界面与沉浸感',
        coverStartColor: Color(0xFF355C74),
        coverEndColor: Color(0xFF152532),
        spineHeight: 114,
        body: _sharedBody,
      ),
    ],
  ),
  SeedCategory(
    id: 'psychology',
    title: 'Psychology',
    books: <SeedBook>[
      SeedBook(
        id: 'human-behavior',
        title: 'Human Behavior',
        author: 'Nina Foster',
        chapterLabel: 'Chapter 6',
        description: '理解阅读行为与习惯触发',
        coverStartColor: Color(0xFFA55D41),
        coverEndColor: Color(0xFF4B2417),
        spineHeight: 120,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'thinking-fast',
        title: 'Thinking Fast',
        author: 'Daniel Ember',
        chapterLabel: 'Chapter 2',
        description: '快思考与慢思考的切换',
        coverStartColor: Color(0xFFC59D53),
        coverEndColor: Color(0xFF6D4F17),
        spineHeight: 118,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'daily-signals',
        title: 'Daily Signals',
        author: 'Irene Bell',
        chapterLabel: 'Chapter 8',
        description: '从细节中读出行为模式',
        coverStartColor: Color(0xFF7B84A8),
        coverEndColor: Color(0xFF353C59),
        spineHeight: 128,
        body: _sharedBody,
      ),
    ],
  ),
  SeedCategory(
    id: 'novels',
    title: 'Novels',
    books: <SeedBook>[
      SeedBook(
        id: 'tiny-stories',
        title: 'Tiny Stories',
        author: 'Luca Green',
        chapterLabel: 'Chapter 1',
        description: '微型叙事与安静的节奏',
        coverStartColor: Color(0xFF7D9B85),
        coverEndColor: Color(0xFF2D4332),
        spineHeight: 122,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'blue-library',
        title: 'Blue Library',
        author: 'Sophie Lane',
        chapterLabel: 'Chapter 5',
        description: '书页、雨夜与旧城市',
        coverStartColor: Color(0xFF4A69A6),
        coverEndColor: Color(0xFF20304D),
        spineHeight: 126,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'paper-world',
        title: 'Paper World',
        author: 'Otis Gray',
        chapterLabel: 'Chapter 7',
        description: '一封封纸信拼出的世界',
        coverStartColor: Color(0xFFB8756B),
        coverEndColor: Color(0xFF5E2B25),
        spineHeight: 118,
        body: _sharedBody,
      ),
      SeedBook(
        id: 'deep-work',
        title: 'Deep Work',
        author: 'Cal Newport',
        chapterLabel: 'Chapter 2',
        description: '专注与深度阅读的节奏',
        coverStartColor: Color(0xFF5F6E7A),
        coverEndColor: Color(0xFF252F37),
        spineHeight: 124,
        body: _sharedBody,
      ),
    ],
  ),
];
