import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

enum ReaderThemePreset {
  paper,
  mist,
  night,
}

enum ReaderTextAlignMode {
  justify,
  left,
}

class ReaderPreferences {
  const ReaderPreferences({
    required this.fontScale,
    required this.lineHeight,
    required this.pagePadding,
    required this.paragraphSpacing,
    required this.paragraphIndent,
    required this.themePreset,
    required this.textAlignMode,
  });

  final double fontScale;
  final double lineHeight;
  final double pagePadding;
  final double paragraphSpacing;
  final double paragraphIndent;
  final ReaderThemePreset themePreset;
  final ReaderTextAlignMode textAlignMode;

  ReaderPreferences copyWith({
    double? fontScale,
    double? lineHeight,
    double? pagePadding,
    double? paragraphSpacing,
    double? paragraphIndent,
    ReaderThemePreset? themePreset,
    ReaderTextAlignMode? textAlignMode,
  }) {
    return ReaderPreferences(
      fontScale: fontScale ?? this.fontScale,
      lineHeight: lineHeight ?? this.lineHeight,
      pagePadding: pagePadding ?? this.pagePadding,
      paragraphSpacing: paragraphSpacing ?? this.paragraphSpacing,
      paragraphIndent: paragraphIndent ?? this.paragraphIndent,
      themePreset: themePreset ?? this.themePreset,
      textAlignMode: textAlignMode ?? this.textAlignMode,
    );
  }
}

final initialReaderPreferencesProvider = Provider<ReaderPreferences>((ref) {
  return const ReaderPreferences(
    fontScale: 1,
    lineHeight: 1.85,
    pagePadding: 8,
    paragraphSpacing: 1,
    paragraphIndent: 2,
    themePreset: ReaderThemePreset.paper,
    textAlignMode: ReaderTextAlignMode.justify,
  );
});

final readerPreferencesProvider = StateNotifierProvider<
    ReaderPreferencesController, ReaderPreferences>((ref) {
  final initialValue = ref.watch(initialReaderPreferencesProvider);
  final service = ref.watch(preferencesServiceProvider);
  return ReaderPreferencesController(
    initialValue: initialValue,
    onChanged: service.saveReaderPreferences,
  );
});

class ReaderPreferencesController extends StateNotifier<ReaderPreferences> {
  ReaderPreferencesController({
    required ReaderPreferences initialValue,
    required this.onChanged,
  }) : super(initialValue);

  final Future<void> Function(ReaderPreferences value) onChanged;

  Future<void> update({
    double? fontScale,
    double? lineHeight,
    double? pagePadding,
    double? paragraphSpacing,
    double? paragraphIndent,
    ReaderThemePreset? themePreset,
    ReaderTextAlignMode? textAlignMode,
  }) async {
    final next = state.copyWith(
      fontScale: fontScale,
      lineHeight: lineHeight,
      pagePadding: pagePadding,
      paragraphSpacing: paragraphSpacing,
      paragraphIndent: paragraphIndent,
      themePreset: themePreset,
      textAlignMode: textAlignMode,
    );
    state = next;
    await onChanged(next);
  }
}
