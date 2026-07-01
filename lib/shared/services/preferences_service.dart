import 'package:shared_preferences/shared_preferences.dart';

import '../providers/locale_provider.dart';
import '../providers/library_preferences_provider.dart';
import '../providers/reader_preferences_provider.dart';
import '../providers/theme_provider.dart';

class PreferencesService {
  PreferencesService(this._preferences);

  static const String _themeModeKey = 'theme_mode';
  static const String _localeModeKey = 'locale_mode';
  static const String _readerFontScaleKey = 'reader_font_scale';
  static const String _readerLineHeightKey = 'reader_line_height';
  static const String _readerPagePaddingKey = 'reader_page_padding';
  static const String _readerParagraphSpacingKey = 'reader_paragraph_spacing';
  static const String _readerParagraphIndentKey = 'reader_paragraph_indent';
  static const String _readerThemePresetKey = 'reader_theme_preset';
  static const String _readerTextAlignModeKey = 'reader_text_align_mode';
  static const String _librarySortModeKey = 'library_sort_mode';

  final SharedPreferences _preferences;

  static Future<PreferencesService> create() async {
    // 统一管理本地轻量配置。
    final preferences = await SharedPreferences.getInstance();
    return PreferencesService(preferences);
  }

  AppThemeMode loadThemeMode() {
    final value = _preferences.getString(_themeModeKey);
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => AppThemeMode.system,
    );
  }

  Future<void> saveThemeMode(AppThemeMode mode) {
    return _preferences.setString(_themeModeKey, mode.name);
  }

  AppLocaleMode loadLocaleMode() {
    final value = _preferences.getString(_localeModeKey);
    return AppLocaleMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => AppLocaleMode.system,
    );
  }

  Future<void> saveLocaleMode(AppLocaleMode mode) {
    return _preferences.setString(_localeModeKey, mode.name);
  }

  LibrarySortMode loadLibrarySortMode() {
    final value = _preferences.getString(_librarySortModeKey);
    return LibrarySortMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => LibrarySortMode.recentRead,
    );
  }

  Future<void> saveLibrarySortMode(LibrarySortMode mode) {
    return _preferences.setString(_librarySortModeKey, mode.name);
  }

  ReaderPreferences loadReaderPreferences() {
    return ReaderPreferences(
      fontScale: _preferences.getDouble(_readerFontScaleKey) ?? 1,
      lineHeight: _preferences.getDouble(_readerLineHeightKey) ?? 1.85,
      pagePadding: _preferences.getDouble(_readerPagePaddingKey) ?? 24,
      paragraphSpacing: _preferences.getDouble(_readerParagraphSpacingKey) ?? 1,
      paragraphIndent: _preferences.getDouble(_readerParagraphIndentKey) ?? 2,
      themePreset: ReaderThemePreset.values.firstWhere(
        (value) => value.name == _preferences.getString(_readerThemePresetKey),
        orElse: () => ReaderThemePreset.paper,
      ),
      textAlignMode: ReaderTextAlignMode.values.firstWhere(
        (value) =>
            value.name == _preferences.getString(_readerTextAlignModeKey),
        orElse: () => ReaderTextAlignMode.justify,
      ),
    );
  }

  Future<void> saveReaderPreferences(ReaderPreferences value) async {
    await _preferences.setDouble(_readerFontScaleKey, value.fontScale);
    await _preferences.setDouble(_readerLineHeightKey, value.lineHeight);
    await _preferences.setDouble(_readerPagePaddingKey, value.pagePadding);
    await _preferences.setDouble(
      _readerParagraphSpacingKey,
      value.paragraphSpacing,
    );
    await _preferences.setDouble(
      _readerParagraphIndentKey,
      value.paragraphIndent,
    );
    await _preferences.setString(_readerThemePresetKey, value.themePreset.name);
    await _preferences.setString(
      _readerTextAlignModeKey,
      value.textAlignMode.name,
    );
  }
}
