// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get librarySubtitle => 'My Favourite';

  @override
  String get libraryTitle => 'BOOKS';

  @override
  String get addBooks => '添加书籍';

  @override
  String get readNow => '阅读';

  @override
  String get backToLibrary => '返回';

  @override
  String get previousChapter => '上一章';

  @override
  String get nextChapter => '下一章';

  @override
  String get tableOfContents => '目录';

  @override
  String get readerAppearance => '排版';

  @override
  String get readerThemePreset => '阅读主题';

  @override
  String get readerThemePaper => '纸张';

  @override
  String get readerThemeMist => '雾蓝';

  @override
  String get readerThemeNight => '夜间';

  @override
  String get readerTextAlign => '对齐方式';

  @override
  String get readerTextAlignJustify => '两端对齐';

  @override
  String get readerTextAlignLeft => '左对齐';

  @override
  String get fontSize => '字号';

  @override
  String get lineHeight => '行距';

  @override
  String get readerPagePadding => '页边距';

  @override
  String get readerParagraphSpacing => '段间距';

  @override
  String get readerParagraphIndent => '首行缩进';

  @override
  String get readerPreviewText => '这是阅读预览文本，用来确认当前主题与排版是否适合长期阅读。';

  @override
  String get bookmarks => '书签';

  @override
  String get toggleBookmark => '切换书签';

  @override
  String get noBookmarks => '当前没有书签';

  @override
  String get searchInBook => '书内搜索';

  @override
  String get searchPlaceholder => '输入关键词';

  @override
  String get searchEmpty => '请输入关键词开始搜索';

  @override
  String get searchNoResult => '没有找到匹配内容';

  @override
  String get settings => '设置';

  @override
  String get theme => '主题';

  @override
  String get appearanceHint => '在白天与夜间都保持安静沉浸的阅读氛围。';

  @override
  String get language => '语言';

  @override
  String get languageHint => '选择界面文案的展示语言。';

  @override
  String get followSystem => '跟随系统';

  @override
  String get lightMode => '浅色模式';

  @override
  String get darkMode => '深色模式';

  @override
  String get debugInfo => '调试信息';

  @override
  String get debugHint => '开发阶段保留环境与平台的可见性。';

  @override
  String get platformTargets => '目标平台：Android / Web / Windows';

  @override
  String get bookNotFound => '未找到图书';

  @override
  String get collectionNotFound => '未找到分类';

  @override
  String get recentReading => '最近阅读';

  @override
  String get manageLibrary => '图书管理';

  @override
  String get importBooksHint => '每行输入一个本地 txt 或 epub 文件路径，可一次导入多本。';

  @override
  String get importBooksAction => '开始导入';

  @override
  String get importFilesAction => '文件导入';

  @override
  String get importDirectoryAction => '目录导入';

  @override
  String get importPathLabel => '文件路径';

  @override
  String get importSuccess => '导入完成';

  @override
  String get importFailed => '导入失败';

  @override
  String get importedBooks => '已导入图书';

  @override
  String get noImportedBooks => '还没有导入图书';

  @override
  String get sortBooks => '书架排序';

  @override
  String get sortRecentRead => '最近阅读';

  @override
  String get sortTitle => '书名';

  @override
  String get sortAuthor => '作者';

  @override
  String get readingStats => '阅读统计';

  @override
  String get totalBooksStarted => '已开始图书';

  @override
  String get totalReadingTime => '累计阅读时长';

  @override
  String get lastReadAt => '最近阅读时间';

  @override
  String get editMetadata => '编辑信息';

  @override
  String get deleteBook => '删除图书';

  @override
  String get confirmDeleteBook => '确认删除这本书？';

  @override
  String get saveAction => '保存';

  @override
  String get cancelAction => '取消';

  @override
  String get bookTitleLabel => '书名';

  @override
  String get bookAuthorLabel => '作者';

  @override
  String get environmentDevelopment => '环境：development';

  @override
  String get environmentStaging => '环境：staging';

  @override
  String get environmentProduction => '环境：production';

  @override
  String bookCount(int count) {
    return '$count 本书';
  }

  @override
  String readingTime(String time) {
    return '$time';
  }
}
