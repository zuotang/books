import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @librarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'My Favourite'**
  String get librarySubtitle;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'BOOKS'**
  String get libraryTitle;

  /// No description provided for @addBooks.
  ///
  /// In en, this message translates to:
  /// **'Add Books'**
  String get addBooks;

  /// No description provided for @readNow.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get readNow;

  /// No description provided for @backToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backToLibrary;

  /// No description provided for @previousChapter.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousChapter;

  /// No description provided for @nextChapter.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextChapter;

  /// No description provided for @tableOfContents.
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get tableOfContents;

  /// No description provided for @readerAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get readerAppearance;

  /// No description provided for @readerThemePreset.
  ///
  /// In en, this message translates to:
  /// **'Reading theme'**
  String get readerThemePreset;

  /// No description provided for @readerThemePaper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get readerThemePaper;

  /// No description provided for @readerThemeMist.
  ///
  /// In en, this message translates to:
  /// **'Mist'**
  String get readerThemeMist;

  /// No description provided for @readerThemeNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get readerThemeNight;

  /// No description provided for @readerTextAlign.
  ///
  /// In en, this message translates to:
  /// **'Alignment'**
  String get readerTextAlign;

  /// No description provided for @readerTextAlignJustify.
  ///
  /// In en, this message translates to:
  /// **'Justify'**
  String get readerTextAlignJustify;

  /// No description provided for @readerTextAlignLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get readerTextAlignLeft;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get fontSize;

  /// No description provided for @lineHeight.
  ///
  /// In en, this message translates to:
  /// **'Line spacing'**
  String get lineHeight;

  /// No description provided for @readerPagePadding.
  ///
  /// In en, this message translates to:
  /// **'Page padding'**
  String get readerPagePadding;

  /// No description provided for @readerParagraphSpacing.
  ///
  /// In en, this message translates to:
  /// **'Paragraph spacing'**
  String get readerParagraphSpacing;

  /// No description provided for @readerParagraphIndent.
  ///
  /// In en, this message translates to:
  /// **'First-line indent'**
  String get readerParagraphIndent;

  /// No description provided for @readerPreviewText.
  ///
  /// In en, this message translates to:
  /// **'This preview text helps verify that the current reading theme and layout fit long-form reading.'**
  String get readerPreviewText;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @toggleBookmark.
  ///
  /// In en, this message translates to:
  /// **'Toggle bookmark'**
  String get toggleBookmark;

  /// No description provided for @noBookmarks.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get noBookmarks;

  /// No description provided for @searchInBook.
  ///
  /// In en, this message translates to:
  /// **'Search in book'**
  String get searchInBook;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter a keyword'**
  String get searchPlaceholder;

  /// No description provided for @searchEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter a keyword to start searching'**
  String get searchEmpty;

  /// No description provided for @searchNoResult.
  ///
  /// In en, this message translates to:
  /// **'No matching content found'**
  String get searchNoResult;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @appearanceHint.
  ///
  /// In en, this message translates to:
  /// **'Keep the reader calm across day and night.'**
  String get appearanceHint;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageHint.
  ///
  /// In en, this message translates to:
  /// **'Choose how the interface presents copy.'**
  String get languageHint;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get followSystem;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// No description provided for @debugInfo.
  ///
  /// In en, this message translates to:
  /// **'Debug info'**
  String get debugInfo;

  /// No description provided for @debugHint.
  ///
  /// In en, this message translates to:
  /// **'Keep the environment and platform visible during development.'**
  String get debugHint;

  /// No description provided for @platformTargets.
  ///
  /// In en, this message translates to:
  /// **'Targets: Android / Web / Windows'**
  String get platformTargets;

  /// No description provided for @bookNotFound.
  ///
  /// In en, this message translates to:
  /// **'Book not found'**
  String get bookNotFound;

  /// No description provided for @collectionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Collection not found'**
  String get collectionNotFound;

  /// No description provided for @recentReading.
  ///
  /// In en, this message translates to:
  /// **'Recent Reading'**
  String get recentReading;

  /// No description provided for @manageLibrary.
  ///
  /// In en, this message translates to:
  /// **'Manage Library'**
  String get manageLibrary;

  /// No description provided for @importBooksHint.
  ///
  /// In en, this message translates to:
  /// **'Enter one local txt or epub file path per line to import multiple books.'**
  String get importBooksHint;

  /// No description provided for @importBooksAction.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importBooksAction;

  /// No description provided for @importPathLabel.
  ///
  /// In en, this message translates to:
  /// **'File path'**
  String get importPathLabel;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import completed'**
  String get importSuccess;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed'**
  String get importFailed;

  /// No description provided for @importedBooks.
  ///
  /// In en, this message translates to:
  /// **'Imported books'**
  String get importedBooks;

  /// No description provided for @noImportedBooks.
  ///
  /// In en, this message translates to:
  /// **'No imported books yet'**
  String get noImportedBooks;

  /// No description provided for @sortBooks.
  ///
  /// In en, this message translates to:
  /// **'Shelf sorting'**
  String get sortBooks;

  /// No description provided for @sortRecentRead.
  ///
  /// In en, this message translates to:
  /// **'Recent reading'**
  String get sortRecentRead;

  /// No description provided for @sortTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get sortTitle;

  /// No description provided for @sortAuthor.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get sortAuthor;

  /// No description provided for @readingStats.
  ///
  /// In en, this message translates to:
  /// **'Reading stats'**
  String get readingStats;

  /// No description provided for @totalBooksStarted.
  ///
  /// In en, this message translates to:
  /// **'Books started'**
  String get totalBooksStarted;

  /// No description provided for @totalReadingTime.
  ///
  /// In en, this message translates to:
  /// **'Total reading time'**
  String get totalReadingTime;

  /// No description provided for @lastReadAt.
  ///
  /// In en, this message translates to:
  /// **'Last read at'**
  String get lastReadAt;

  /// No description provided for @editMetadata.
  ///
  /// In en, this message translates to:
  /// **'Edit metadata'**
  String get editMetadata;

  /// No description provided for @deleteBook.
  ///
  /// In en, this message translates to:
  /// **'Delete book'**
  String get deleteBook;

  /// No description provided for @confirmDeleteBook.
  ///
  /// In en, this message translates to:
  /// **'Delete this book?'**
  String get confirmDeleteBook;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @bookTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get bookTitleLabel;

  /// No description provided for @bookAuthorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get bookAuthorLabel;

  /// No description provided for @environmentDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Environment: development'**
  String get environmentDevelopment;

  /// No description provided for @environmentStaging.
  ///
  /// In en, this message translates to:
  /// **'Environment: staging'**
  String get environmentStaging;

  /// No description provided for @environmentProduction.
  ///
  /// In en, this message translates to:
  /// **'Environment: production'**
  String get environmentProduction;

  /// No description provided for @bookCount.
  ///
  /// In en, this message translates to:
  /// **'{count} books'**
  String bookCount(int count);

  /// No description provided for @readingTime.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String readingTime(String time);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
