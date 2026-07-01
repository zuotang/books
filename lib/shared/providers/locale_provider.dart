import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

enum AppLocaleMode {
  system(null),
  zhCn(Locale('zh', 'CN')),
  enUs(Locale('en', 'US'));

  const AppLocaleMode(this.locale);

  final Locale? locale;

  static const List<Locale> supportedLocales = <Locale>[
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];
}

final initialLocaleModeProvider = Provider<AppLocaleMode>((ref) {
  return AppLocaleMode.system;
});

final localeModeProvider =
    StateNotifierProvider<LocaleModeController, AppLocaleMode>((ref) {
  final initialMode = ref.watch(initialLocaleModeProvider);
  final service = ref.watch(preferencesServiceProvider);
  return LocaleModeController(
    initialMode: initialMode,
    onChanged: service.saveLocaleMode,
  );
});

class LocaleModeController extends StateNotifier<AppLocaleMode> {
  LocaleModeController({
    required AppLocaleMode initialMode,
    required this.onChanged,
  }) : super(initialMode);

  final Future<void> Function(AppLocaleMode mode) onChanged;

  Future<void> update(AppLocaleMode mode) async {
    if (state == mode) {
      return;
    }

    // 语言设置走统一入口，避免页面直接写存储。
    state = mode;
    await onChanged(mode);
  }
}
