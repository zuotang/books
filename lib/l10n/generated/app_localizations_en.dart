// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get librarySubtitle => 'My Favourite';

  @override
  String get libraryTitle => 'BOOKS';

  @override
  String get addBooks => 'Add Books';

  @override
  String get readNow => 'Read';

  @override
  String get backToLibrary => 'Back';

  @override
  String get previousChapter => 'Previous';

  @override
  String get nextChapter => 'Next';

  @override
  String get tableOfContents => 'Contents';

  @override
  String get readerAppearance => 'Appearance';

  @override
  String get readerThemePreset => 'Reading theme';

  @override
  String get readerThemePaper => 'Paper';

  @override
  String get readerThemeMist => 'Mist';

  @override
  String get readerThemeNight => 'Night';

  @override
  String get readerTextAlign => 'Alignment';

  @override
  String get readerTextAlignJustify => 'Justify';

  @override
  String get readerTextAlignLeft => 'Left';

  @override
  String get fontSize => 'Font size';

  @override
  String get lineHeight => 'Line spacing';

  @override
  String get readerPagePadding => 'Page padding';

  @override
  String get readerParagraphSpacing => 'Paragraph spacing';

  @override
  String get readerParagraphIndent => 'First-line indent';

  @override
  String get readerPreviewText =>
      'This preview text helps verify that the current reading theme and layout fit long-form reading.';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get toggleBookmark => 'Toggle bookmark';

  @override
  String get noBookmarks => 'No bookmarks yet';

  @override
  String get searchInBook => 'Search in book';

  @override
  String get searchPlaceholder => 'Enter a keyword';

  @override
  String get searchEmpty => 'Enter a keyword to start searching';

  @override
  String get searchNoResult => 'No matching content found';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get appearanceHint => 'Keep the reader calm across day and night.';

  @override
  String get language => 'Language';

  @override
  String get languageHint => 'Choose how the interface presents copy.';

  @override
  String get followSystem => 'Follow system';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get debugInfo => 'Debug info';

  @override
  String get debugHint =>
      'Keep the environment and platform visible during development.';

  @override
  String get platformTargets => 'Targets: Android / Web / Windows';

  @override
  String get bookNotFound => 'Book not found';

  @override
  String get collectionNotFound => 'Collection not found';

  @override
  String get recentReading => 'Recent Reading';

  @override
  String get manageLibrary => 'Manage Library';

  @override
  String get importBooksHint =>
      'Enter one local txt or epub file path per line to import multiple books.';

  @override
  String get importBooksAction => 'Import';

  @override
  String get importPathLabel => 'File path';

  @override
  String get importSuccess => 'Import completed';

  @override
  String get importFailed => 'Import failed';

  @override
  String get importedBooks => 'Imported books';

  @override
  String get noImportedBooks => 'No imported books yet';

  @override
  String get sortBooks => 'Shelf sorting';

  @override
  String get sortRecentRead => 'Recent reading';

  @override
  String get sortTitle => 'Title';

  @override
  String get sortAuthor => 'Author';

  @override
  String get readingStats => 'Reading stats';

  @override
  String get totalBooksStarted => 'Books started';

  @override
  String get totalReadingTime => 'Total reading time';

  @override
  String get lastReadAt => 'Last read at';

  @override
  String get editMetadata => 'Edit metadata';

  @override
  String get deleteBook => 'Delete book';

  @override
  String get confirmDeleteBook => 'Delete this book?';

  @override
  String get saveAction => 'Save';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get bookTitleLabel => 'Title';

  @override
  String get bookAuthorLabel => 'Author';

  @override
  String get environmentDevelopment => 'Environment: development';

  @override
  String get environmentStaging => 'Environment: staging';

  @override
  String get environmentProduction => 'Environment: production';

  @override
  String bookCount(int count) {
    return '$count books';
  }

  @override
  String readingTime(String time) {
    return '$time';
  }
}
