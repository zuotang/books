import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/app_logger.dart';
import '../../data/local/db/app_database.dart';
import '../../data/local/db/app_database_provider.dart';
import '../../features/library/application/services/sample_book_importer.dart';
import '../../shared/providers/locale_provider.dart';
import '../../shared/providers/library_preferences_provider.dart';
import '../../shared/providers/preferences_provider.dart';
import '../../shared/providers/reader_preferences_provider.dart';
import '../../shared/providers/theme_provider.dart';
import '../../shared/services/preferences_service.dart';
import '../app.dart';
import 'app_config.dart';
import 'app_config_provider.dart';

Future<void> bootstrap({required AppConfig config}) async {
  final logger = AppLogger();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // 启动前先恢复本地设置。
      final preferencesService = await PreferencesService.create();
      final appDatabase = AppDatabase();
      await appDatabase.ensureCompatibleSchema();
      await appDatabase.seedDemoLibraryIfNeeded();
      await importBundledSampleIfExists(appDatabase);

      FlutterError.onError = (details) {
        logger.logFlutterError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        logger.error('捕获到未处理的平台异常', error, stack);
        return true;
      };

      runApp(
        ProviderScope(
          overrides: [
            appConfigProvider.overrideWithValue(config),
            appDatabaseProvider.overrideWithValue(appDatabase),
            preferencesServiceProvider.overrideWithValue(preferencesService),
            initialThemeModeProvider.overrideWithValue(
              preferencesService.loadThemeMode(),
            ),
            initialLocaleModeProvider.overrideWithValue(
              preferencesService.loadLocaleMode(),
            ),
            initialLibrarySortModeProvider.overrideWithValue(
              preferencesService.loadLibrarySortMode(),
            ),
            initialReaderPreferencesProvider.overrideWithValue(
              preferencesService.loadReaderPreferences(),
            ),
          ],
          child: BookApp(config: config),
        ),
      );
    },
    (error, stack) {
      logger.error('捕获到未处理的 Zone 异常', error, stack);
    },
  );
}
