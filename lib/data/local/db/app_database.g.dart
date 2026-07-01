// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, DbCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class DbCategory extends DataClass implements Insertable<DbCategory> {
  final String id;
  final String title;
  const DbCategory({required this.id, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(id: Value(id), title: Value(title));
  }

  factory DbCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCategory(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  DbCategory copyWith({String? id, String? title}) =>
      DbCategory(id: id ?? this.id, title: title ?? this.title);
  DbCategory copyWithCompanion(CategoryTableCompanion data) {
    return DbCategory(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCategory(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCategory && other.id == this.id && other.title == this.title);
}

class CategoryTableCompanion extends UpdateCompanion<DbCategory> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> rowid;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    required String id,
    required String title,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<DbCategory> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? rowid,
  }) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookTableTable extends BookTable
    with TableInfo<$BookTableTable, DbBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES category_table (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterLabelMeta = const VerificationMeta(
    'chapterLabel',
  );
  @override
  late final GeneratedColumn<String> chapterLabel = GeneratedColumn<String>(
    'chapter_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverStartColorMeta = const VerificationMeta(
    'coverStartColor',
  );
  @override
  late final GeneratedColumn<int> coverStartColor = GeneratedColumn<int>(
    'cover_start_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverEndColorMeta = const VerificationMeta(
    'coverEndColor',
  );
  @override
  late final GeneratedColumn<int> coverEndColor = GeneratedColumn<int>(
    'cover_end_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spineHeightMeta = const VerificationMeta(
    'spineHeight',
  );
  @override
  late final GeneratedColumn<double> spineHeight = GeneratedColumn<double>(
    'spine_height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    title,
    author,
    chapterLabel,
    description,
    coverStartColor,
    coverEndColor,
    spineHeight,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('chapter_label')) {
      context.handle(
        _chapterLabelMeta,
        chapterLabel.isAcceptableOrUnknown(
          data['chapter_label']!,
          _chapterLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterLabelMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cover_start_color')) {
      context.handle(
        _coverStartColorMeta,
        coverStartColor.isAcceptableOrUnknown(
          data['cover_start_color']!,
          _coverStartColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coverStartColorMeta);
    }
    if (data.containsKey('cover_end_color')) {
      context.handle(
        _coverEndColorMeta,
        coverEndColor.isAcceptableOrUnknown(
          data['cover_end_color']!,
          _coverEndColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coverEndColorMeta);
    }
    if (data.containsKey('spine_height')) {
      context.handle(
        _spineHeightMeta,
        spineHeight.isAcceptableOrUnknown(
          data['spine_height']!,
          _spineHeightMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spineHeightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBook(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      chapterLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_label'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      coverStartColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cover_start_color'],
      )!,
      coverEndColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cover_end_color'],
      )!,
      spineHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}spine_height'],
      )!,
    );
  }

  @override
  $BookTableTable createAlias(String alias) {
    return $BookTableTable(attachedDatabase, alias);
  }
}

class DbBook extends DataClass implements Insertable<DbBook> {
  final String id;
  final String categoryId;
  final String title;
  final String author;
  final String chapterLabel;
  final String description;
  final int coverStartColor;
  final int coverEndColor;
  final double spineHeight;
  const DbBook({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.author,
    required this.chapterLabel,
    required this.description,
    required this.coverStartColor,
    required this.coverEndColor,
    required this.spineHeight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['chapter_label'] = Variable<String>(chapterLabel);
    map['description'] = Variable<String>(description);
    map['cover_start_color'] = Variable<int>(coverStartColor);
    map['cover_end_color'] = Variable<int>(coverEndColor);
    map['spine_height'] = Variable<double>(spineHeight);
    return map;
  }

  BookTableCompanion toCompanion(bool nullToAbsent) {
    return BookTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      title: Value(title),
      author: Value(author),
      chapterLabel: Value(chapterLabel),
      description: Value(description),
      coverStartColor: Value(coverStartColor),
      coverEndColor: Value(coverEndColor),
      spineHeight: Value(spineHeight),
    );
  }

  factory DbBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBook(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      chapterLabel: serializer.fromJson<String>(json['chapterLabel']),
      description: serializer.fromJson<String>(json['description']),
      coverStartColor: serializer.fromJson<int>(json['coverStartColor']),
      coverEndColor: serializer.fromJson<int>(json['coverEndColor']),
      spineHeight: serializer.fromJson<double>(json['spineHeight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'chapterLabel': serializer.toJson<String>(chapterLabel),
      'description': serializer.toJson<String>(description),
      'coverStartColor': serializer.toJson<int>(coverStartColor),
      'coverEndColor': serializer.toJson<int>(coverEndColor),
      'spineHeight': serializer.toJson<double>(spineHeight),
    };
  }

  DbBook copyWith({
    String? id,
    String? categoryId,
    String? title,
    String? author,
    String? chapterLabel,
    String? description,
    int? coverStartColor,
    int? coverEndColor,
    double? spineHeight,
  }) => DbBook(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    title: title ?? this.title,
    author: author ?? this.author,
    chapterLabel: chapterLabel ?? this.chapterLabel,
    description: description ?? this.description,
    coverStartColor: coverStartColor ?? this.coverStartColor,
    coverEndColor: coverEndColor ?? this.coverEndColor,
    spineHeight: spineHeight ?? this.spineHeight,
  );
  DbBook copyWithCompanion(BookTableCompanion data) {
    return DbBook(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      chapterLabel: data.chapterLabel.present
          ? data.chapterLabel.value
          : this.chapterLabel,
      description: data.description.present
          ? data.description.value
          : this.description,
      coverStartColor: data.coverStartColor.present
          ? data.coverStartColor.value
          : this.coverStartColor,
      coverEndColor: data.coverEndColor.present
          ? data.coverEndColor.value
          : this.coverEndColor,
      spineHeight: data.spineHeight.present
          ? data.spineHeight.value
          : this.spineHeight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBook(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('chapterLabel: $chapterLabel, ')
          ..write('description: $description, ')
          ..write('coverStartColor: $coverStartColor, ')
          ..write('coverEndColor: $coverEndColor, ')
          ..write('spineHeight: $spineHeight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    title,
    author,
    chapterLabel,
    description,
    coverStartColor,
    coverEndColor,
    spineHeight,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBook &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.title == this.title &&
          other.author == this.author &&
          other.chapterLabel == this.chapterLabel &&
          other.description == this.description &&
          other.coverStartColor == this.coverStartColor &&
          other.coverEndColor == this.coverEndColor &&
          other.spineHeight == this.spineHeight);
}

class BookTableCompanion extends UpdateCompanion<DbBook> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> title;
  final Value<String> author;
  final Value<String> chapterLabel;
  final Value<String> description;
  final Value<int> coverStartColor;
  final Value<int> coverEndColor;
  final Value<double> spineHeight;
  final Value<int> rowid;
  const BookTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.chapterLabel = const Value.absent(),
    this.description = const Value.absent(),
    this.coverStartColor = const Value.absent(),
    this.coverEndColor = const Value.absent(),
    this.spineHeight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookTableCompanion.insert({
    required String id,
    required String categoryId,
    required String title,
    required String author,
    required String chapterLabel,
    required String description,
    required int coverStartColor,
    required int coverEndColor,
    required double spineHeight,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       title = Value(title),
       author = Value(author),
       chapterLabel = Value(chapterLabel),
       description = Value(description),
       coverStartColor = Value(coverStartColor),
       coverEndColor = Value(coverEndColor),
       spineHeight = Value(spineHeight);
  static Insertable<DbBook> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? chapterLabel,
    Expression<String>? description,
    Expression<int>? coverStartColor,
    Expression<int>? coverEndColor,
    Expression<double>? spineHeight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (chapterLabel != null) 'chapter_label': chapterLabel,
      if (description != null) 'description': description,
      if (coverStartColor != null) 'cover_start_color': coverStartColor,
      if (coverEndColor != null) 'cover_end_color': coverEndColor,
      if (spineHeight != null) 'spine_height': spineHeight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookTableCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? title,
    Value<String>? author,
    Value<String>? chapterLabel,
    Value<String>? description,
    Value<int>? coverStartColor,
    Value<int>? coverEndColor,
    Value<double>? spineHeight,
    Value<int>? rowid,
  }) {
    return BookTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      author: author ?? this.author,
      chapterLabel: chapterLabel ?? this.chapterLabel,
      description: description ?? this.description,
      coverStartColor: coverStartColor ?? this.coverStartColor,
      coverEndColor: coverEndColor ?? this.coverEndColor,
      spineHeight: spineHeight ?? this.spineHeight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (chapterLabel.present) {
      map['chapter_label'] = Variable<String>(chapterLabel.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverStartColor.present) {
      map['cover_start_color'] = Variable<int>(coverStartColor.value);
    }
    if (coverEndColor.present) {
      map['cover_end_color'] = Variable<int>(coverEndColor.value);
    }
    if (spineHeight.present) {
      map['spine_height'] = Variable<double>(spineHeight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('chapterLabel: $chapterLabel, ')
          ..write('description: $description, ')
          ..write('coverStartColor: $coverStartColor, ')
          ..write('coverEndColor: $coverEndColor, ')
          ..write('spineHeight: $spineHeight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookChapterTableTable extends BookChapterTable
    with TableInfo<$BookChapterTableTable, DbBookChapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookChapterTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES book_table (id)',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paragraphsJsonMeta = const VerificationMeta(
    'paragraphsJson',
  );
  @override
  late final GeneratedColumn<String> paragraphsJson = GeneratedColumn<String>(
    'paragraphs_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    orderIndex,
    title,
    paragraphsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_chapter_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBookChapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('paragraphs_json')) {
      context.handle(
        _paragraphsJsonMeta,
        paragraphsJson.isAcceptableOrUnknown(
          data['paragraphs_json']!,
          _paragraphsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paragraphsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBookChapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookChapter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      paragraphsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paragraphs_json'],
      )!,
    );
  }

  @override
  $BookChapterTableTable createAlias(String alias) {
    return $BookChapterTableTable(attachedDatabase, alias);
  }
}

class DbBookChapter extends DataClass implements Insertable<DbBookChapter> {
  final String id;
  final String bookId;
  final int orderIndex;
  final String title;
  final String paragraphsJson;
  const DbBookChapter({
    required this.id,
    required this.bookId,
    required this.orderIndex,
    required this.title,
    required this.paragraphsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['order_index'] = Variable<int>(orderIndex);
    map['title'] = Variable<String>(title);
    map['paragraphs_json'] = Variable<String>(paragraphsJson);
    return map;
  }

  BookChapterTableCompanion toCompanion(bool nullToAbsent) {
    return BookChapterTableCompanion(
      id: Value(id),
      bookId: Value(bookId),
      orderIndex: Value(orderIndex),
      title: Value(title),
      paragraphsJson: Value(paragraphsJson),
    );
  }

  factory DbBookChapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookChapter(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      title: serializer.fromJson<String>(json['title']),
      paragraphsJson: serializer.fromJson<String>(json['paragraphsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'title': serializer.toJson<String>(title),
      'paragraphsJson': serializer.toJson<String>(paragraphsJson),
    };
  }

  DbBookChapter copyWith({
    String? id,
    String? bookId,
    int? orderIndex,
    String? title,
    String? paragraphsJson,
  }) => DbBookChapter(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    orderIndex: orderIndex ?? this.orderIndex,
    title: title ?? this.title,
    paragraphsJson: paragraphsJson ?? this.paragraphsJson,
  );
  DbBookChapter copyWithCompanion(BookChapterTableCompanion data) {
    return DbBookChapter(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      title: data.title.present ? data.title.value : this.title,
      paragraphsJson: data.paragraphsJson.present
          ? data.paragraphsJson.value
          : this.paragraphsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBookChapter(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('paragraphsJson: $paragraphsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, orderIndex, title, paragraphsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookChapter &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.orderIndex == this.orderIndex &&
          other.title == this.title &&
          other.paragraphsJson == this.paragraphsJson);
}

class BookChapterTableCompanion extends UpdateCompanion<DbBookChapter> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<int> orderIndex;
  final Value<String> title;
  final Value<String> paragraphsJson;
  final Value<int> rowid;
  const BookChapterTableCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.title = const Value.absent(),
    this.paragraphsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookChapterTableCompanion.insert({
    required String id,
    required String bookId,
    required int orderIndex,
    required String title,
    required String paragraphsJson,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       orderIndex = Value(orderIndex),
       title = Value(title),
       paragraphsJson = Value(paragraphsJson);
  static Insertable<DbBookChapter> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<int>? orderIndex,
    Expression<String>? title,
    Expression<String>? paragraphsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (title != null) 'title': title,
      if (paragraphsJson != null) 'paragraphs_json': paragraphsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookChapterTableCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<int>? orderIndex,
    Value<String>? title,
    Value<String>? paragraphsJson,
    Value<int>? rowid,
  }) {
    return BookChapterTableCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      orderIndex: orderIndex ?? this.orderIndex,
      title: title ?? this.title,
      paragraphsJson: paragraphsJson ?? this.paragraphsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (paragraphsJson.present) {
      map['paragraphs_json'] = Variable<String>(paragraphsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookChapterTableCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('paragraphsJson: $paragraphsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTableTable extends ReadingProgressTable
    with TableInfo<$ReadingProgressTableTable, DbReadingProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES book_table (id)',
    ),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chapterLabelMeta = const VerificationMeta(
    'chapterLabel',
  );
  @override
  late final GeneratedColumn<String> chapterLabel = GeneratedColumn<String>(
    'chapter_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    progress,
    chapterId,
    chapterLabel,
    pageIndex,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbReadingProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    }
    if (data.containsKey('chapter_label')) {
      context.handle(
        _chapterLabelMeta,
        chapterLabel.isAcceptableOrUnknown(
          data['chapter_label']!,
          _chapterLabelMeta,
        ),
      );
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbReadingProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbReadingProgressEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      ),
      chapterLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_label'],
      ),
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReadingProgressTableTable createAlias(String alias) {
    return $ReadingProgressTableTable(attachedDatabase, alias);
  }
}

class DbReadingProgressEntry extends DataClass
    implements Insertable<DbReadingProgressEntry> {
  final int id;
  final String bookId;
  final double progress;
  final String? chapterId;
  final String? chapterLabel;
  final int pageIndex;
  final DateTime updatedAt;
  const DbReadingProgressEntry({
    required this.id,
    required this.bookId,
    required this.progress,
    this.chapterId,
    this.chapterLabel,
    required this.pageIndex,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<String>(bookId);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || chapterId != null) {
      map['chapter_id'] = Variable<String>(chapterId);
    }
    if (!nullToAbsent || chapterLabel != null) {
      map['chapter_label'] = Variable<String>(chapterLabel);
    }
    map['page_index'] = Variable<int>(pageIndex);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadingProgressTableCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressTableCompanion(
      id: Value(id),
      bookId: Value(bookId),
      progress: Value(progress),
      chapterId: chapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterId),
      chapterLabel: chapterLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterLabel),
      pageIndex: Value(pageIndex),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbReadingProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbReadingProgressEntry(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      progress: serializer.fromJson<double>(json['progress']),
      chapterId: serializer.fromJson<String?>(json['chapterId']),
      chapterLabel: serializer.fromJson<String?>(json['chapterLabel']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<String>(bookId),
      'progress': serializer.toJson<double>(progress),
      'chapterId': serializer.toJson<String?>(chapterId),
      'chapterLabel': serializer.toJson<String?>(chapterLabel),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbReadingProgressEntry copyWith({
    int? id,
    String? bookId,
    double? progress,
    Value<String?> chapterId = const Value.absent(),
    Value<String?> chapterLabel = const Value.absent(),
    int? pageIndex,
    DateTime? updatedAt,
  }) => DbReadingProgressEntry(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    progress: progress ?? this.progress,
    chapterId: chapterId.present ? chapterId.value : this.chapterId,
    chapterLabel: chapterLabel.present ? chapterLabel.value : this.chapterLabel,
    pageIndex: pageIndex ?? this.pageIndex,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DbReadingProgressEntry copyWithCompanion(ReadingProgressTableCompanion data) {
    return DbReadingProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      progress: data.progress.present ? data.progress.value : this.progress,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      chapterLabel: data.chapterLabel.present
          ? data.chapterLabel.value
          : this.chapterLabel,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbReadingProgressEntry(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('progress: $progress, ')
          ..write('chapterId: $chapterId, ')
          ..write('chapterLabel: $chapterLabel, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    progress,
    chapterId,
    chapterLabel,
    pageIndex,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbReadingProgressEntry &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.progress == this.progress &&
          other.chapterId == this.chapterId &&
          other.chapterLabel == this.chapterLabel &&
          other.pageIndex == this.pageIndex &&
          other.updatedAt == this.updatedAt);
}

class ReadingProgressTableCompanion
    extends UpdateCompanion<DbReadingProgressEntry> {
  final Value<int> id;
  final Value<String> bookId;
  final Value<double> progress;
  final Value<String?> chapterId;
  final Value<String?> chapterLabel;
  final Value<int> pageIndex;
  final Value<DateTime> updatedAt;
  const ReadingProgressTableCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.progress = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.chapterLabel = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReadingProgressTableCompanion.insert({
    this.id = const Value.absent(),
    required String bookId,
    this.progress = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.chapterLabel = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : bookId = Value(bookId);
  static Insertable<DbReadingProgressEntry> custom({
    Expression<int>? id,
    Expression<String>? bookId,
    Expression<double>? progress,
    Expression<String>? chapterId,
    Expression<String>? chapterLabel,
    Expression<int>? pageIndex,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (progress != null) 'progress': progress,
      if (chapterId != null) 'chapter_id': chapterId,
      if (chapterLabel != null) 'chapter_label': chapterLabel,
      if (pageIndex != null) 'page_index': pageIndex,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReadingProgressTableCompanion copyWith({
    Value<int>? id,
    Value<String>? bookId,
    Value<double>? progress,
    Value<String?>? chapterId,
    Value<String?>? chapterLabel,
    Value<int>? pageIndex,
    Value<DateTime>? updatedAt,
  }) {
    return ReadingProgressTableCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      progress: progress ?? this.progress,
      chapterId: chapterId ?? this.chapterId,
      chapterLabel: chapterLabel ?? this.chapterLabel,
      pageIndex: pageIndex ?? this.pageIndex,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (chapterLabel.present) {
      map['chapter_label'] = Variable<String>(chapterLabel.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressTableCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('progress: $progress, ')
          ..write('chapterId: $chapterId, ')
          ..write('chapterLabel: $chapterLabel, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BookmarkTableTable extends BookmarkTable
    with TableInfo<$BookmarkTableTable, DbBookmarkEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES book_table (id)',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES book_chapter_table (id)',
    ),
  );
  static const VerificationMeta _chapterTitleMeta = const VerificationMeta(
    'chapterTitle',
  );
  @override
  late final GeneratedColumn<String> chapterTitle = GeneratedColumn<String>(
    'chapter_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _excerptMeta = const VerificationMeta(
    'excerpt',
  );
  @override
  late final GeneratedColumn<String> excerpt = GeneratedColumn<String>(
    'excerpt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapterId,
    chapterTitle,
    pageIndex,
    progress,
    excerpt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmark_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBookmarkEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('chapter_title')) {
      context.handle(
        _chapterTitleMeta,
        chapterTitle.isAcceptableOrUnknown(
          data['chapter_title']!,
          _chapterTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chapterTitleMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('excerpt')) {
      context.handle(
        _excerptMeta,
        excerpt.isAcceptableOrUnknown(data['excerpt']!, _excerptMeta),
      );
    } else if (isInserting) {
      context.missing(_excerptMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {bookId, chapterId, pageIndex},
  ];
  @override
  DbBookmarkEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookmarkEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      chapterTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_title'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      excerpt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}excerpt'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarkTableTable createAlias(String alias) {
    return $BookmarkTableTable(attachedDatabase, alias);
  }
}

class DbBookmarkEntry extends DataClass implements Insertable<DbBookmarkEntry> {
  final int id;
  final String bookId;
  final String chapterId;
  final String chapterTitle;
  final int pageIndex;
  final double progress;
  final String excerpt;
  final DateTime createdAt;
  const DbBookmarkEntry({
    required this.id,
    required this.bookId,
    required this.chapterId,
    required this.chapterTitle,
    required this.pageIndex,
    required this.progress,
    required this.excerpt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<String>(bookId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['chapter_title'] = Variable<String>(chapterTitle);
    map['page_index'] = Variable<int>(pageIndex);
    map['progress'] = Variable<double>(progress);
    map['excerpt'] = Variable<String>(excerpt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarkTableCompanion toCompanion(bool nullToAbsent) {
    return BookmarkTableCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapterId: Value(chapterId),
      chapterTitle: Value(chapterTitle),
      pageIndex: Value(pageIndex),
      progress: Value(progress),
      excerpt: Value(excerpt),
      createdAt: Value(createdAt),
    );
  }

  factory DbBookmarkEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookmarkEntry(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      chapterTitle: serializer.fromJson<String>(json['chapterTitle']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      progress: serializer.fromJson<double>(json['progress']),
      excerpt: serializer.fromJson<String>(json['excerpt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<String>(bookId),
      'chapterId': serializer.toJson<String>(chapterId),
      'chapterTitle': serializer.toJson<String>(chapterTitle),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'progress': serializer.toJson<double>(progress),
      'excerpt': serializer.toJson<String>(excerpt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbBookmarkEntry copyWith({
    int? id,
    String? bookId,
    String? chapterId,
    String? chapterTitle,
    int? pageIndex,
    double? progress,
    String? excerpt,
    DateTime? createdAt,
  }) => DbBookmarkEntry(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapterId: chapterId ?? this.chapterId,
    chapterTitle: chapterTitle ?? this.chapterTitle,
    pageIndex: pageIndex ?? this.pageIndex,
    progress: progress ?? this.progress,
    excerpt: excerpt ?? this.excerpt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbBookmarkEntry copyWithCompanion(BookmarkTableCompanion data) {
    return DbBookmarkEntry(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      chapterTitle: data.chapterTitle.present
          ? data.chapterTitle.value
          : this.chapterTitle,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      progress: data.progress.present ? data.progress.value : this.progress,
      excerpt: data.excerpt.present ? data.excerpt.value : this.excerpt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBookmarkEntry(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterId: $chapterId, ')
          ..write('chapterTitle: $chapterTitle, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('progress: $progress, ')
          ..write('excerpt: $excerpt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapterId,
    chapterTitle,
    pageIndex,
    progress,
    excerpt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookmarkEntry &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapterId == this.chapterId &&
          other.chapterTitle == this.chapterTitle &&
          other.pageIndex == this.pageIndex &&
          other.progress == this.progress &&
          other.excerpt == this.excerpt &&
          other.createdAt == this.createdAt);
}

class BookmarkTableCompanion extends UpdateCompanion<DbBookmarkEntry> {
  final Value<int> id;
  final Value<String> bookId;
  final Value<String> chapterId;
  final Value<String> chapterTitle;
  final Value<int> pageIndex;
  final Value<double> progress;
  final Value<String> excerpt;
  final Value<DateTime> createdAt;
  const BookmarkTableCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.chapterTitle = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.progress = const Value.absent(),
    this.excerpt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarkTableCompanion.insert({
    this.id = const Value.absent(),
    required String bookId,
    required String chapterId,
    required String chapterTitle,
    required int pageIndex,
    this.progress = const Value.absent(),
    required String excerpt,
    this.createdAt = const Value.absent(),
  }) : bookId = Value(bookId),
       chapterId = Value(chapterId),
       chapterTitle = Value(chapterTitle),
       pageIndex = Value(pageIndex),
       excerpt = Value(excerpt);
  static Insertable<DbBookmarkEntry> custom({
    Expression<int>? id,
    Expression<String>? bookId,
    Expression<String>? chapterId,
    Expression<String>? chapterTitle,
    Expression<int>? pageIndex,
    Expression<double>? progress,
    Expression<String>? excerpt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (chapterTitle != null) 'chapter_title': chapterTitle,
      if (pageIndex != null) 'page_index': pageIndex,
      if (progress != null) 'progress': progress,
      if (excerpt != null) 'excerpt': excerpt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarkTableCompanion copyWith({
    Value<int>? id,
    Value<String>? bookId,
    Value<String>? chapterId,
    Value<String>? chapterTitle,
    Value<int>? pageIndex,
    Value<double>? progress,
    Value<String>? excerpt,
    Value<DateTime>? createdAt,
  }) {
    return BookmarkTableCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      pageIndex: pageIndex ?? this.pageIndex,
      progress: progress ?? this.progress,
      excerpt: excerpt ?? this.excerpt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (chapterTitle.present) {
      map['chapter_title'] = Variable<String>(chapterTitle.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (excerpt.present) {
      map['excerpt'] = Variable<String>(excerpt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkTableCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterId: $chapterId, ')
          ..write('chapterTitle: $chapterTitle, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('progress: $progress, ')
          ..write('excerpt: $excerpt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingStatsTableTable extends ReadingStatsTable
    with TableInfo<$ReadingStatsTableTable, DbReadingStatsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES book_table (id)',
    ),
  );
  static const VerificationMeta _totalReadingSecondsMeta =
      const VerificationMeta('totalReadingSeconds');
  @override
  late final GeneratedColumn<int> totalReadingSeconds = GeneratedColumn<int>(
    'total_reading_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionCountMeta = const VerificationMeta(
    'sessionCount',
  );
  @override
  late final GeneratedColumn<int> sessionCount = GeneratedColumn<int>(
    'session_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastProgressMeta = const VerificationMeta(
    'lastProgress',
  );
  @override
  late final GeneratedColumn<double> lastProgress = GeneratedColumn<double>(
    'last_progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReadAt = GeneratedColumn<DateTime>(
    'last_read_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    totalReadingSeconds,
    sessionCount,
    lastProgress,
    lastReadAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_stats_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbReadingStatsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('total_reading_seconds')) {
      context.handle(
        _totalReadingSecondsMeta,
        totalReadingSeconds.isAcceptableOrUnknown(
          data['total_reading_seconds']!,
          _totalReadingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('session_count')) {
      context.handle(
        _sessionCountMeta,
        sessionCount.isAcceptableOrUnknown(
          data['session_count']!,
          _sessionCountMeta,
        ),
      );
    }
    if (data.containsKey('last_progress')) {
      context.handle(
        _lastProgressMeta,
        lastProgress.isAcceptableOrUnknown(
          data['last_progress']!,
          _lastProgressMeta,
        ),
      );
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbReadingStatsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbReadingStatsEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      totalReadingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_reading_seconds'],
      )!,
      sessionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_count'],
      )!,
      lastProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_progress'],
      )!,
      lastReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_read_at'],
      )!,
    );
  }

  @override
  $ReadingStatsTableTable createAlias(String alias) {
    return $ReadingStatsTableTable(attachedDatabase, alias);
  }
}

class DbReadingStatsEntry extends DataClass
    implements Insertable<DbReadingStatsEntry> {
  final int id;
  final String bookId;
  final int totalReadingSeconds;
  final int sessionCount;
  final double lastProgress;
  final DateTime lastReadAt;
  const DbReadingStatsEntry({
    required this.id,
    required this.bookId,
    required this.totalReadingSeconds,
    required this.sessionCount,
    required this.lastProgress,
    required this.lastReadAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<String>(bookId);
    map['total_reading_seconds'] = Variable<int>(totalReadingSeconds);
    map['session_count'] = Variable<int>(sessionCount);
    map['last_progress'] = Variable<double>(lastProgress);
    map['last_read_at'] = Variable<DateTime>(lastReadAt);
    return map;
  }

  ReadingStatsTableCompanion toCompanion(bool nullToAbsent) {
    return ReadingStatsTableCompanion(
      id: Value(id),
      bookId: Value(bookId),
      totalReadingSeconds: Value(totalReadingSeconds),
      sessionCount: Value(sessionCount),
      lastProgress: Value(lastProgress),
      lastReadAt: Value(lastReadAt),
    );
  }

  factory DbReadingStatsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbReadingStatsEntry(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      totalReadingSeconds: serializer.fromJson<int>(
        json['totalReadingSeconds'],
      ),
      sessionCount: serializer.fromJson<int>(json['sessionCount']),
      lastProgress: serializer.fromJson<double>(json['lastProgress']),
      lastReadAt: serializer.fromJson<DateTime>(json['lastReadAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<String>(bookId),
      'totalReadingSeconds': serializer.toJson<int>(totalReadingSeconds),
      'sessionCount': serializer.toJson<int>(sessionCount),
      'lastProgress': serializer.toJson<double>(lastProgress),
      'lastReadAt': serializer.toJson<DateTime>(lastReadAt),
    };
  }

  DbReadingStatsEntry copyWith({
    int? id,
    String? bookId,
    int? totalReadingSeconds,
    int? sessionCount,
    double? lastProgress,
    DateTime? lastReadAt,
  }) => DbReadingStatsEntry(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    totalReadingSeconds: totalReadingSeconds ?? this.totalReadingSeconds,
    sessionCount: sessionCount ?? this.sessionCount,
    lastProgress: lastProgress ?? this.lastProgress,
    lastReadAt: lastReadAt ?? this.lastReadAt,
  );
  DbReadingStatsEntry copyWithCompanion(ReadingStatsTableCompanion data) {
    return DbReadingStatsEntry(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      totalReadingSeconds: data.totalReadingSeconds.present
          ? data.totalReadingSeconds.value
          : this.totalReadingSeconds,
      sessionCount: data.sessionCount.present
          ? data.sessionCount.value
          : this.sessionCount,
      lastProgress: data.lastProgress.present
          ? data.lastProgress.value
          : this.lastProgress,
      lastReadAt: data.lastReadAt.present
          ? data.lastReadAt.value
          : this.lastReadAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbReadingStatsEntry(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('totalReadingSeconds: $totalReadingSeconds, ')
          ..write('sessionCount: $sessionCount, ')
          ..write('lastProgress: $lastProgress, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    totalReadingSeconds,
    sessionCount,
    lastProgress,
    lastReadAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbReadingStatsEntry &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.totalReadingSeconds == this.totalReadingSeconds &&
          other.sessionCount == this.sessionCount &&
          other.lastProgress == this.lastProgress &&
          other.lastReadAt == this.lastReadAt);
}

class ReadingStatsTableCompanion extends UpdateCompanion<DbReadingStatsEntry> {
  final Value<int> id;
  final Value<String> bookId;
  final Value<int> totalReadingSeconds;
  final Value<int> sessionCount;
  final Value<double> lastProgress;
  final Value<DateTime> lastReadAt;
  const ReadingStatsTableCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.totalReadingSeconds = const Value.absent(),
    this.sessionCount = const Value.absent(),
    this.lastProgress = const Value.absent(),
    this.lastReadAt = const Value.absent(),
  });
  ReadingStatsTableCompanion.insert({
    this.id = const Value.absent(),
    required String bookId,
    this.totalReadingSeconds = const Value.absent(),
    this.sessionCount = const Value.absent(),
    this.lastProgress = const Value.absent(),
    this.lastReadAt = const Value.absent(),
  }) : bookId = Value(bookId);
  static Insertable<DbReadingStatsEntry> custom({
    Expression<int>? id,
    Expression<String>? bookId,
    Expression<int>? totalReadingSeconds,
    Expression<int>? sessionCount,
    Expression<double>? lastProgress,
    Expression<DateTime>? lastReadAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (totalReadingSeconds != null)
        'total_reading_seconds': totalReadingSeconds,
      if (sessionCount != null) 'session_count': sessionCount,
      if (lastProgress != null) 'last_progress': lastProgress,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
    });
  }

  ReadingStatsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? bookId,
    Value<int>? totalReadingSeconds,
    Value<int>? sessionCount,
    Value<double>? lastProgress,
    Value<DateTime>? lastReadAt,
  }) {
    return ReadingStatsTableCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      totalReadingSeconds: totalReadingSeconds ?? this.totalReadingSeconds,
      sessionCount: sessionCount ?? this.sessionCount,
      lastProgress: lastProgress ?? this.lastProgress,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (totalReadingSeconds.present) {
      map['total_reading_seconds'] = Variable<int>(totalReadingSeconds.value);
    }
    if (sessionCount.present) {
      map['session_count'] = Variable<int>(sessionCount.value);
    }
    if (lastProgress.present) {
      map['last_progress'] = Variable<double>(lastProgress.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingStatsTableCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('totalReadingSeconds: $totalReadingSeconds, ')
          ..write('sessionCount: $sessionCount, ')
          ..write('lastProgress: $lastProgress, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $BookTableTable bookTable = $BookTableTable(this);
  late final $BookChapterTableTable bookChapterTable = $BookChapterTableTable(
    this,
  );
  late final $ReadingProgressTableTable readingProgressTable =
      $ReadingProgressTableTable(this);
  late final $BookmarkTableTable bookmarkTable = $BookmarkTableTable(this);
  late final $ReadingStatsTableTable readingStatsTable =
      $ReadingStatsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoryTable,
    bookTable,
    bookChapterTable,
    readingProgressTable,
    bookmarkTable,
    readingStatsTable,
  ];
}

typedef $$CategoryTableTableCreateCompanionBuilder =
    CategoryTableCompanion Function({
      required String id,
      required String title,
      Value<int> rowid,
    });
typedef $$CategoryTableTableUpdateCompanionBuilder =
    CategoryTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> rowid,
    });

final class $$CategoryTableTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryTableTable, DbCategory> {
  $$CategoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BookTableTable, List<DbBook>> _bookTableRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bookTable,
    aliasName: 'category_table__id__book_table__category_id',
  );

  $$BookTableTableProcessedTableManager get bookTableRefs {
    final manager = $$BookTableTableTableManager(
      $_db,
      $_db.bookTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bookTableRefs(
    Expression<bool> Function($$BookTableTableFilterComposer f) f,
  ) {
    final $$BookTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableFilterComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  Expression<T> bookTableRefs<T extends Object>(
    Expression<T> Function($$BookTableTableAnnotationComposer a) f,
  ) {
    final $$BookTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryTableTable,
          DbCategory,
          $$CategoryTableTableFilterComposer,
          $$CategoryTableTableOrderingComposer,
          $$CategoryTableTableAnnotationComposer,
          $$CategoryTableTableCreateCompanionBuilder,
          $$CategoryTableTableUpdateCompanionBuilder,
          (DbCategory, $$CategoryTableTableReferences),
          DbCategory,
          PrefetchHooks Function({bool bookTableRefs})
        > {
  $$CategoryTableTableTableManager(_$AppDatabase db, $CategoryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion(id: id, title: title, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion.insert(
                id: id,
                title: title,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bookTableRefs) db.bookTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookTableRefs)
                    await $_getPrefetchedData<
                      DbCategory,
                      $CategoryTableTable,
                      DbBook
                    >(
                      currentTable: table,
                      referencedTable: $$CategoryTableTableReferences
                          ._bookTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoryTableTableReferences(
                            db,
                            table,
                            p0,
                          ).bookTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryTableTable,
      DbCategory,
      $$CategoryTableTableFilterComposer,
      $$CategoryTableTableOrderingComposer,
      $$CategoryTableTableAnnotationComposer,
      $$CategoryTableTableCreateCompanionBuilder,
      $$CategoryTableTableUpdateCompanionBuilder,
      (DbCategory, $$CategoryTableTableReferences),
      DbCategory,
      PrefetchHooks Function({bool bookTableRefs})
    >;
typedef $$BookTableTableCreateCompanionBuilder =
    BookTableCompanion Function({
      required String id,
      required String categoryId,
      required String title,
      required String author,
      required String chapterLabel,
      required String description,
      required int coverStartColor,
      required int coverEndColor,
      required double spineHeight,
      Value<int> rowid,
    });
typedef $$BookTableTableUpdateCompanionBuilder =
    BookTableCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<String> title,
      Value<String> author,
      Value<String> chapterLabel,
      Value<String> description,
      Value<int> coverStartColor,
      Value<int> coverEndColor,
      Value<double> spineHeight,
      Value<int> rowid,
    });

final class $$BookTableTableReferences
    extends BaseReferences<_$AppDatabase, $BookTableTable, DbBook> {
  $$BookTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTableTable _categoryIdTable(_$AppDatabase db) => db
      .categoryTable
      .createAlias('book_table__category_id__category_table__id');

  $$CategoryTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoryTableTableTableManager(
      $_db,
      $_db.categoryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BookChapterTableTable, List<DbBookChapter>>
  _bookChapterTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookChapterTable,
    aliasName: 'book_table__id__book_chapter_table__book_id',
  );

  $$BookChapterTableTableProcessedTableManager get bookChapterTableRefs {
    final manager = $$BookChapterTableTableTableManager(
      $_db,
      $_db.bookChapterTable,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bookChapterTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ReadingProgressTableTable,
    List<DbReadingProgressEntry>
  >
  _readingProgressTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingProgressTable,
        aliasName: 'book_table__id__reading_progress_table__book_id',
      );

  $$ReadingProgressTableTableProcessedTableManager
  get readingProgressTableRefs {
    final manager = $$ReadingProgressTableTableTableManager(
      $_db,
      $_db.readingProgressTable,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingProgressTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookmarkTableTable, List<DbBookmarkEntry>>
  _bookmarkTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarkTable,
    aliasName: 'book_table__id__bookmark_table__book_id',
  );

  $$BookmarkTableTableProcessedTableManager get bookmarkTableRefs {
    final manager = $$BookmarkTableTableTableManager(
      $_db,
      $_db.bookmarkTable,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarkTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingStatsTableTable, List<DbReadingStatsEntry>>
  _readingStatsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingStatsTable,
        aliasName: 'book_table__id__reading_stats_table__book_id',
      );

  $$ReadingStatsTableTableProcessedTableManager get readingStatsTableRefs {
    final manager = $$ReadingStatsTableTableTableManager(
      $_db,
      $_db.readingStatsTable,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingStatsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BookTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookTableTable> {
  $$BookTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverStartColor => $composableBuilder(
    column: $table.coverStartColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coverEndColor => $composableBuilder(
    column: $table.coverEndColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get spineHeight => $composableBuilder(
    column: $table.spineHeight,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoryTableTableFilterComposer get categoryId {
    final $$CategoryTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableFilterComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bookChapterTableRefs(
    Expression<bool> Function($$BookChapterTableTableFilterComposer f) f,
  ) {
    final $$BookChapterTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookChapterTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookChapterTableTableFilterComposer(
            $db: $db,
            $table: $db.bookChapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingProgressTableRefs(
    Expression<bool> Function($$ReadingProgressTableTableFilterComposer f) f,
  ) {
    final $$ReadingProgressTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingProgressTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingProgressTableTableFilterComposer(
            $db: $db,
            $table: $db.readingProgressTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookmarkTableRefs(
    Expression<bool> Function($$BookmarkTableTableFilterComposer f) f,
  ) {
    final $$BookmarkTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarkTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarkTableTableFilterComposer(
            $db: $db,
            $table: $db.bookmarkTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingStatsTableRefs(
    Expression<bool> Function($$ReadingStatsTableTableFilterComposer f) f,
  ) {
    final $$ReadingStatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingStatsTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingStatsTableTableFilterComposer(
            $db: $db,
            $table: $db.readingStatsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookTableTable> {
  $$BookTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverStartColor => $composableBuilder(
    column: $table.coverStartColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coverEndColor => $composableBuilder(
    column: $table.coverEndColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get spineHeight => $composableBuilder(
    column: $table.spineHeight,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoryTableTableOrderingComposer get categoryId {
    final $$CategoryTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookTableTable> {
  $$BookTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coverStartColor => $composableBuilder(
    column: $table.coverStartColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coverEndColor => $composableBuilder(
    column: $table.coverEndColor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get spineHeight => $composableBuilder(
    column: $table.spineHeight,
    builder: (column) => column,
  );

  $$CategoryTableTableAnnotationComposer get categoryId {
    final $$CategoryTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bookChapterTableRefs<T extends Object>(
    Expression<T> Function($$BookChapterTableTableAnnotationComposer a) f,
  ) {
    final $$BookChapterTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookChapterTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookChapterTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookChapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingProgressTableRefs<T extends Object>(
    Expression<T> Function($$ReadingProgressTableTableAnnotationComposer a) f,
  ) {
    final $$ReadingProgressTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.readingProgressTable,
          getReferencedColumn: (t) => t.bookId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReadingProgressTableTableAnnotationComposer(
                $db: $db,
                $table: $db.readingProgressTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> bookmarkTableRefs<T extends Object>(
    Expression<T> Function($$BookmarkTableTableAnnotationComposer a) f,
  ) {
    final $$BookmarkTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarkTable,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarkTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarkTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingStatsTableRefs<T extends Object>(
    Expression<T> Function($$ReadingStatsTableTableAnnotationComposer a) f,
  ) {
    final $$ReadingStatsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.readingStatsTable,
          getReferencedColumn: (t) => t.bookId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReadingStatsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.readingStatsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BookTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookTableTable,
          DbBook,
          $$BookTableTableFilterComposer,
          $$BookTableTableOrderingComposer,
          $$BookTableTableAnnotationComposer,
          $$BookTableTableCreateCompanionBuilder,
          $$BookTableTableUpdateCompanionBuilder,
          (DbBook, $$BookTableTableReferences),
          DbBook,
          PrefetchHooks Function({
            bool categoryId,
            bool bookChapterTableRefs,
            bool readingProgressTableRefs,
            bool bookmarkTableRefs,
            bool readingStatsTableRefs,
          })
        > {
  $$BookTableTableTableManager(_$AppDatabase db, $BookTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> chapterLabel = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> coverStartColor = const Value.absent(),
                Value<int> coverEndColor = const Value.absent(),
                Value<double> spineHeight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookTableCompanion(
                id: id,
                categoryId: categoryId,
                title: title,
                author: author,
                chapterLabel: chapterLabel,
                description: description,
                coverStartColor: coverStartColor,
                coverEndColor: coverEndColor,
                spineHeight: spineHeight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String title,
                required String author,
                required String chapterLabel,
                required String description,
                required int coverStartColor,
                required int coverEndColor,
                required double spineHeight,
                Value<int> rowid = const Value.absent(),
              }) => BookTableCompanion.insert(
                id: id,
                categoryId: categoryId,
                title: title,
                author: author,
                chapterLabel: chapterLabel,
                description: description,
                coverStartColor: coverStartColor,
                coverEndColor: coverEndColor,
                spineHeight: spineHeight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                bookChapterTableRefs = false,
                readingProgressTableRefs = false,
                bookmarkTableRefs = false,
                readingStatsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bookChapterTableRefs) db.bookChapterTable,
                    if (readingProgressTableRefs) db.readingProgressTable,
                    if (bookmarkTableRefs) db.bookmarkTable,
                    if (readingStatsTableRefs) db.readingStatsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$BookTableTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$BookTableTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bookChapterTableRefs)
                        await $_getPrefetchedData<
                          DbBook,
                          $BookTableTable,
                          DbBookChapter
                        >(
                          currentTable: table,
                          referencedTable: $$BookTableTableReferences
                              ._bookChapterTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BookTableTableReferences(
                                db,
                                table,
                                p0,
                              ).bookChapterTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingProgressTableRefs)
                        await $_getPrefetchedData<
                          DbBook,
                          $BookTableTable,
                          DbReadingProgressEntry
                        >(
                          currentTable: table,
                          referencedTable: $$BookTableTableReferences
                              ._readingProgressTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BookTableTableReferences(
                                db,
                                table,
                                p0,
                              ).readingProgressTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookmarkTableRefs)
                        await $_getPrefetchedData<
                          DbBook,
                          $BookTableTable,
                          DbBookmarkEntry
                        >(
                          currentTable: table,
                          referencedTable: $$BookTableTableReferences
                              ._bookmarkTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BookTableTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarkTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingStatsTableRefs)
                        await $_getPrefetchedData<
                          DbBook,
                          $BookTableTable,
                          DbReadingStatsEntry
                        >(
                          currentTable: table,
                          referencedTable: $$BookTableTableReferences
                              ._readingStatsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BookTableTableReferences(
                                db,
                                table,
                                p0,
                              ).readingStatsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BookTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookTableTable,
      DbBook,
      $$BookTableTableFilterComposer,
      $$BookTableTableOrderingComposer,
      $$BookTableTableAnnotationComposer,
      $$BookTableTableCreateCompanionBuilder,
      $$BookTableTableUpdateCompanionBuilder,
      (DbBook, $$BookTableTableReferences),
      DbBook,
      PrefetchHooks Function({
        bool categoryId,
        bool bookChapterTableRefs,
        bool readingProgressTableRefs,
        bool bookmarkTableRefs,
        bool readingStatsTableRefs,
      })
    >;
typedef $$BookChapterTableTableCreateCompanionBuilder =
    BookChapterTableCompanion Function({
      required String id,
      required String bookId,
      required int orderIndex,
      required String title,
      required String paragraphsJson,
      Value<int> rowid,
    });
typedef $$BookChapterTableTableUpdateCompanionBuilder =
    BookChapterTableCompanion Function({
      Value<String> id,
      Value<String> bookId,
      Value<int> orderIndex,
      Value<String> title,
      Value<String> paragraphsJson,
      Value<int> rowid,
    });

final class $$BookChapterTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $BookChapterTableTable, DbBookChapter> {
  $$BookChapterTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BookTableTable _bookIdTable(_$AppDatabase db) =>
      db.bookTable.createAlias('book_chapter_table__book_id__book_table__id');

  $$BookTableTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BookTableTableTableManager(
      $_db,
      $_db.bookTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BookmarkTableTable, List<DbBookmarkEntry>>
  _bookmarkTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarkTable,
    aliasName: 'book_chapter_table__id__bookmark_table__chapter_id',
  );

  $$BookmarkTableTableProcessedTableManager get bookmarkTableRefs {
    final manager = $$BookmarkTableTableTableManager(
      $_db,
      $_db.bookmarkTable,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarkTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BookChapterTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookChapterTableTable> {
  $$BookChapterTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paragraphsJson => $composableBuilder(
    column: $table.paragraphsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$BookTableTableFilterComposer get bookId {
    final $$BookTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableFilterComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bookmarkTableRefs(
    Expression<bool> Function($$BookmarkTableTableFilterComposer f) f,
  ) {
    final $$BookmarkTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarkTable,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarkTableTableFilterComposer(
            $db: $db,
            $table: $db.bookmarkTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookChapterTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookChapterTableTable> {
  $$BookChapterTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paragraphsJson => $composableBuilder(
    column: $table.paragraphsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookTableTableOrderingComposer get bookId {
    final $$BookTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableOrderingComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookChapterTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookChapterTableTable> {
  $$BookChapterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get paragraphsJson => $composableBuilder(
    column: $table.paragraphsJson,
    builder: (column) => column,
  );

  $$BookTableTableAnnotationComposer get bookId {
    final $$BookTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bookmarkTableRefs<T extends Object>(
    Expression<T> Function($$BookmarkTableTableAnnotationComposer a) f,
  ) {
    final $$BookmarkTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarkTable,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarkTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarkTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookChapterTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookChapterTableTable,
          DbBookChapter,
          $$BookChapterTableTableFilterComposer,
          $$BookChapterTableTableOrderingComposer,
          $$BookChapterTableTableAnnotationComposer,
          $$BookChapterTableTableCreateCompanionBuilder,
          $$BookChapterTableTableUpdateCompanionBuilder,
          (DbBookChapter, $$BookChapterTableTableReferences),
          DbBookChapter,
          PrefetchHooks Function({bool bookId, bool bookmarkTableRefs})
        > {
  $$BookChapterTableTableTableManager(
    _$AppDatabase db,
    $BookChapterTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookChapterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookChapterTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookChapterTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> paragraphsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookChapterTableCompanion(
                id: id,
                bookId: bookId,
                orderIndex: orderIndex,
                title: title,
                paragraphsJson: paragraphsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                required int orderIndex,
                required String title,
                required String paragraphsJson,
                Value<int> rowid = const Value.absent(),
              }) => BookChapterTableCompanion.insert(
                id: id,
                bookId: bookId,
                orderIndex: orderIndex,
                title: title,
                paragraphsJson: paragraphsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookChapterTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false, bookmarkTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bookmarkTableRefs) db.bookmarkTable,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable:
                                    $$BookChapterTableTableReferences
                                        ._bookIdTable(db),
                                referencedColumn:
                                    $$BookChapterTableTableReferences
                                        ._bookIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookmarkTableRefs)
                    await $_getPrefetchedData<
                      DbBookChapter,
                      $BookChapterTableTable,
                      DbBookmarkEntry
                    >(
                      currentTable: table,
                      referencedTable: $$BookChapterTableTableReferences
                          ._bookmarkTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BookChapterTableTableReferences(
                            db,
                            table,
                            p0,
                          ).bookmarkTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BookChapterTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookChapterTableTable,
      DbBookChapter,
      $$BookChapterTableTableFilterComposer,
      $$BookChapterTableTableOrderingComposer,
      $$BookChapterTableTableAnnotationComposer,
      $$BookChapterTableTableCreateCompanionBuilder,
      $$BookChapterTableTableUpdateCompanionBuilder,
      (DbBookChapter, $$BookChapterTableTableReferences),
      DbBookChapter,
      PrefetchHooks Function({bool bookId, bool bookmarkTableRefs})
    >;
typedef $$ReadingProgressTableTableCreateCompanionBuilder =
    ReadingProgressTableCompanion Function({
      Value<int> id,
      required String bookId,
      Value<double> progress,
      Value<String?> chapterId,
      Value<String?> chapterLabel,
      Value<int> pageIndex,
      Value<DateTime> updatedAt,
    });
typedef $$ReadingProgressTableTableUpdateCompanionBuilder =
    ReadingProgressTableCompanion Function({
      Value<int> id,
      Value<String> bookId,
      Value<double> progress,
      Value<String?> chapterId,
      Value<String?> chapterLabel,
      Value<int> pageIndex,
      Value<DateTime> updatedAt,
    });

final class $$ReadingProgressTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingProgressTableTable,
          DbReadingProgressEntry
        > {
  $$ReadingProgressTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BookTableTable _bookIdTable(_$AppDatabase db) => db.bookTable
      .createAlias('reading_progress_table__book_id__book_table__id');

  $$BookTableTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BookTableTableTableManager(
      $_db,
      $_db.bookTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BookTableTableFilterComposer get bookId {
    final $$BookTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableFilterComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookTableTableOrderingComposer get bookId {
    final $$BookTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableOrderingComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTableTable> {
  $$ReadingProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<String> get chapterLabel => $composableBuilder(
    column: $table.chapterLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BookTableTableAnnotationComposer get bookId {
    final $$BookTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingProgressTableTable,
          DbReadingProgressEntry,
          $$ReadingProgressTableTableFilterComposer,
          $$ReadingProgressTableTableOrderingComposer,
          $$ReadingProgressTableTableAnnotationComposer,
          $$ReadingProgressTableTableCreateCompanionBuilder,
          $$ReadingProgressTableTableUpdateCompanionBuilder,
          (DbReadingProgressEntry, $$ReadingProgressTableTableReferences),
          DbReadingProgressEntry,
          PrefetchHooks Function({bool bookId})
        > {
  $$ReadingProgressTableTableTableManager(
    _$AppDatabase db,
    $ReadingProgressTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<String?> chapterLabel = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReadingProgressTableCompanion(
                id: id,
                bookId: bookId,
                progress: progress,
                chapterId: chapterId,
                chapterLabel: chapterLabel,
                pageIndex: pageIndex,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bookId,
                Value<double> progress = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<String?> chapterLabel = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReadingProgressTableCompanion.insert(
                id: id,
                bookId: bookId,
                progress: progress,
                chapterId: chapterId,
                chapterLabel: chapterLabel,
                pageIndex: pageIndex,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingProgressTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable:
                                    $$ReadingProgressTableTableReferences
                                        ._bookIdTable(db),
                                referencedColumn:
                                    $$ReadingProgressTableTableReferences
                                        ._bookIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingProgressTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingProgressTableTable,
      DbReadingProgressEntry,
      $$ReadingProgressTableTableFilterComposer,
      $$ReadingProgressTableTableOrderingComposer,
      $$ReadingProgressTableTableAnnotationComposer,
      $$ReadingProgressTableTableCreateCompanionBuilder,
      $$ReadingProgressTableTableUpdateCompanionBuilder,
      (DbReadingProgressEntry, $$ReadingProgressTableTableReferences),
      DbReadingProgressEntry,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$BookmarkTableTableCreateCompanionBuilder =
    BookmarkTableCompanion Function({
      Value<int> id,
      required String bookId,
      required String chapterId,
      required String chapterTitle,
      required int pageIndex,
      Value<double> progress,
      required String excerpt,
      Value<DateTime> createdAt,
    });
typedef $$BookmarkTableTableUpdateCompanionBuilder =
    BookmarkTableCompanion Function({
      Value<int> id,
      Value<String> bookId,
      Value<String> chapterId,
      Value<String> chapterTitle,
      Value<int> pageIndex,
      Value<double> progress,
      Value<String> excerpt,
      Value<DateTime> createdAt,
    });

final class $$BookmarkTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $BookmarkTableTable, DbBookmarkEntry> {
  $$BookmarkTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BookTableTable _bookIdTable(_$AppDatabase db) =>
      db.bookTable.createAlias('bookmark_table__book_id__book_table__id');

  $$BookTableTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BookTableTableTableManager(
      $_db,
      $_db.bookTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BookChapterTableTable _chapterIdTable(_$AppDatabase db) => db
      .bookChapterTable
      .createAlias('bookmark_table__chapter_id__book_chapter_table__id');

  $$BookChapterTableTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$BookChapterTableTableTableManager(
      $_db,
      $_db.bookChapterTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarkTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excerpt => $composableBuilder(
    column: $table.excerpt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BookTableTableFilterComposer get bookId {
    final $$BookTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableFilterComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookChapterTableTableFilterComposer get chapterId {
    final $$BookChapterTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.bookChapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookChapterTableTableFilterComposer(
            $db: $db,
            $table: $db.bookChapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarkTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excerpt => $composableBuilder(
    column: $table.excerpt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookTableTableOrderingComposer get bookId {
    final $$BookTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableOrderingComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookChapterTableTableOrderingComposer get chapterId {
    final $$BookChapterTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.bookChapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookChapterTableTableOrderingComposer(
            $db: $db,
            $table: $db.bookChapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarkTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarkTableTable> {
  $$BookmarkTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get excerpt =>
      $composableBuilder(column: $table.excerpt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BookTableTableAnnotationComposer get bookId {
    final $$BookTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BookChapterTableTableAnnotationComposer get chapterId {
    final $$BookChapterTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.bookChapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookChapterTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookChapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarkTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarkTableTable,
          DbBookmarkEntry,
          $$BookmarkTableTableFilterComposer,
          $$BookmarkTableTableOrderingComposer,
          $$BookmarkTableTableAnnotationComposer,
          $$BookmarkTableTableCreateCompanionBuilder,
          $$BookmarkTableTableUpdateCompanionBuilder,
          (DbBookmarkEntry, $$BookmarkTableTableReferences),
          DbBookmarkEntry,
          PrefetchHooks Function({bool bookId, bool chapterId})
        > {
  $$BookmarkTableTableTableManager(_$AppDatabase db, $BookmarkTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarkTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarkTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarkTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> chapterTitle = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String> excerpt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarkTableCompanion(
                id: id,
                bookId: bookId,
                chapterId: chapterId,
                chapterTitle: chapterTitle,
                pageIndex: pageIndex,
                progress: progress,
                excerpt: excerpt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bookId,
                required String chapterId,
                required String chapterTitle,
                required int pageIndex,
                Value<double> progress = const Value.absent(),
                required String excerpt,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarkTableCompanion.insert(
                id: id,
                bookId: bookId,
                chapterId: chapterId,
                chapterTitle: chapterTitle,
                pageIndex: pageIndex,
                progress: progress,
                excerpt: excerpt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarkTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false, chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$BookmarkTableTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$BookmarkTableTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (chapterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chapterId,
                                referencedTable: $$BookmarkTableTableReferences
                                    ._chapterIdTable(db),
                                referencedColumn: $$BookmarkTableTableReferences
                                    ._chapterIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookmarkTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarkTableTable,
      DbBookmarkEntry,
      $$BookmarkTableTableFilterComposer,
      $$BookmarkTableTableOrderingComposer,
      $$BookmarkTableTableAnnotationComposer,
      $$BookmarkTableTableCreateCompanionBuilder,
      $$BookmarkTableTableUpdateCompanionBuilder,
      (DbBookmarkEntry, $$BookmarkTableTableReferences),
      DbBookmarkEntry,
      PrefetchHooks Function({bool bookId, bool chapterId})
    >;
typedef $$ReadingStatsTableTableCreateCompanionBuilder =
    ReadingStatsTableCompanion Function({
      Value<int> id,
      required String bookId,
      Value<int> totalReadingSeconds,
      Value<int> sessionCount,
      Value<double> lastProgress,
      Value<DateTime> lastReadAt,
    });
typedef $$ReadingStatsTableTableUpdateCompanionBuilder =
    ReadingStatsTableCompanion Function({
      Value<int> id,
      Value<String> bookId,
      Value<int> totalReadingSeconds,
      Value<int> sessionCount,
      Value<double> lastProgress,
      Value<DateTime> lastReadAt,
    });

final class $$ReadingStatsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingStatsTableTable,
          DbReadingStatsEntry
        > {
  $$ReadingStatsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BookTableTable _bookIdTable(_$AppDatabase db) =>
      db.bookTable.createAlias('reading_stats_table__book_id__book_table__id');

  $$BookTableTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BookTableTableTableManager(
      $_db,
      $_db.bookTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingStatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingStatsTableTable> {
  $$ReadingStatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionCount => $composableBuilder(
    column: $table.sessionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastProgress => $composableBuilder(
    column: $table.lastProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BookTableTableFilterComposer get bookId {
    final $$BookTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableFilterComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingStatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingStatsTableTable> {
  $$ReadingStatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionCount => $composableBuilder(
    column: $table.sessionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastProgress => $composableBuilder(
    column: $table.lastProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookTableTableOrderingComposer get bookId {
    final $$BookTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableOrderingComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingStatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingStatsTableTable> {
  $$ReadingStatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sessionCount => $composableBuilder(
    column: $table.sessionCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastProgress => $composableBuilder(
    column: $table.lastProgress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  $$BookTableTableAnnotationComposer get bookId {
    final $$BookTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.bookTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bookTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingStatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingStatsTableTable,
          DbReadingStatsEntry,
          $$ReadingStatsTableTableFilterComposer,
          $$ReadingStatsTableTableOrderingComposer,
          $$ReadingStatsTableTableAnnotationComposer,
          $$ReadingStatsTableTableCreateCompanionBuilder,
          $$ReadingStatsTableTableUpdateCompanionBuilder,
          (DbReadingStatsEntry, $$ReadingStatsTableTableReferences),
          DbReadingStatsEntry,
          PrefetchHooks Function({bool bookId})
        > {
  $$ReadingStatsTableTableTableManager(
    _$AppDatabase db,
    $ReadingStatsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingStatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingStatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingStatsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> totalReadingSeconds = const Value.absent(),
                Value<int> sessionCount = const Value.absent(),
                Value<double> lastProgress = const Value.absent(),
                Value<DateTime> lastReadAt = const Value.absent(),
              }) => ReadingStatsTableCompanion(
                id: id,
                bookId: bookId,
                totalReadingSeconds: totalReadingSeconds,
                sessionCount: sessionCount,
                lastProgress: lastProgress,
                lastReadAt: lastReadAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bookId,
                Value<int> totalReadingSeconds = const Value.absent(),
                Value<int> sessionCount = const Value.absent(),
                Value<double> lastProgress = const Value.absent(),
                Value<DateTime> lastReadAt = const Value.absent(),
              }) => ReadingStatsTableCompanion.insert(
                id: id,
                bookId: bookId,
                totalReadingSeconds: totalReadingSeconds,
                sessionCount: sessionCount,
                lastProgress: lastProgress,
                lastReadAt: lastReadAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingStatsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable:
                                    $$ReadingStatsTableTableReferences
                                        ._bookIdTable(db),
                                referencedColumn:
                                    $$ReadingStatsTableTableReferences
                                        ._bookIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingStatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingStatsTableTable,
      DbReadingStatsEntry,
      $$ReadingStatsTableTableFilterComposer,
      $$ReadingStatsTableTableOrderingComposer,
      $$ReadingStatsTableTableAnnotationComposer,
      $$ReadingStatsTableTableCreateCompanionBuilder,
      $$ReadingStatsTableTableUpdateCompanionBuilder,
      (DbReadingStatsEntry, $$ReadingStatsTableTableReferences),
      DbReadingStatsEntry,
      PrefetchHooks Function({bool bookId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$BookTableTableTableManager get bookTable =>
      $$BookTableTableTableManager(_db, _db.bookTable);
  $$BookChapterTableTableTableManager get bookChapterTable =>
      $$BookChapterTableTableTableManager(_db, _db.bookChapterTable);
  $$ReadingProgressTableTableTableManager get readingProgressTable =>
      $$ReadingProgressTableTableTableManager(_db, _db.readingProgressTable);
  $$BookmarkTableTableTableManager get bookmarkTable =>
      $$BookmarkTableTableTableManager(_db, _db.bookmarkTable);
  $$ReadingStatsTableTableTableManager get readingStatsTable =>
      $$ReadingStatsTableTableTableManager(_db, _db.readingStatsTable);
}
