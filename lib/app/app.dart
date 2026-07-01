import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';
import '../shared/providers/locale_provider.dart';
import '../shared/providers/theme_provider.dart';
import 'bootstrap/app_config.dart';
import 'router/app_router.dart';
import 'scroll/app_scroll_behavior.dart';
import 'theme/app_theme.dart';

class BookApp extends ConsumerWidget {
  const BookApp({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final localeMode = ref.watch(localeModeProvider);

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode.themeMode,
      locale: localeMode.locale,
      routerConfig: appRouter,
      scrollBehavior: const AppScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
