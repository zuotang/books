import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

enum AppThemeMode {
  system,
  light,
  dark;

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}

final initialThemeModeProvider = Provider<AppThemeMode>((ref) {
  return AppThemeMode.system;
});

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, AppThemeMode>((ref) {
  final initialMode = ref.watch(initialThemeModeProvider);
  final service = ref.watch(preferencesServiceProvider);
  return ThemeModeController(
    initialMode: initialMode,
    onChanged: service.saveThemeMode,
  );
});

class ThemeModeController extends StateNotifier<AppThemeMode> {
  ThemeModeController({
    required AppThemeMode initialMode,
    required this.onChanged,
  }) : super(initialMode);

  final Future<void> Function(AppThemeMode mode) onChanged;

  Future<void> update(AppThemeMode mode) async {
    if (state == mode) {
      return;
    }

    // 切换后立即持久化，保证多端启动一致。
    state = mode;
    await onChanged(mode);
  }
}
