import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/bootstrap/app_env.dart';
import '../../../../app/bootstrap/app_config_provider.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/providers/locale_provider.dart';
import '../../../../shared/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonalIcon(
                  onPressed: context.pop,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  label: Text(
                    l10n.backToLibrary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const Expanded(child: SettingsBody()),
          ],
        ),
      ),
    );
  }
}

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: SettingsBody(compact: true));
  }
}

class SettingsBody extends ConsumerWidget {
  const SettingsBody({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final localeMode = ref.watch(localeModeProvider);
    final appConfig = ref.watch(appConfigProvider);
    final themeController = ref.read(themeModeProvider.notifier);
    final localeController = ref.read(localeModeProvider.notifier);
    final horizontalPadding = compact ? 20.0 : 24.0;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        compact ? 8 : 16,
        horizontalPadding,
        24,
      ),
      children: <Widget>[
        if (!compact)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Text(
              l10n.settings,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        _SettingsCard(
          title: l10n.theme,
          subtitle: l10n.appearanceHint,
          child: _ScrollableSegmentedButton<AppThemeMode>(
            child: SegmentedButton<AppThemeMode>(
              segments: AppThemeMode.values.map((mode) {
                return ButtonSegment<AppThemeMode>(
                  value: mode,
                  label: Text(_themeLabel(l10n, mode)),
                );
              }).toList(),
              selected: <AppThemeMode>{themeMode},
              showSelectedIcon: false,
              onSelectionChanged: (selection) {
                themeController.update(selection.first);
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _SettingsCard(
          title: l10n.language,
          subtitle: l10n.languageHint,
          child: _ScrollableSegmentedButton<AppLocaleMode>(
            child: SegmentedButton<AppLocaleMode>(
              segments: AppLocaleMode.values.map((mode) {
                return ButtonSegment<AppLocaleMode>(
                  value: mode,
                  label: Text(_localeLabel(l10n, mode)),
                );
              }).toList(),
              selected: <AppLocaleMode>{localeMode},
              showSelectedIcon: false,
              onSelectionChanged: (selection) {
                localeController.update(selection.first);
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _SettingsCard(
          title: l10n.manageLibrary,
          subtitle: l10n.importBooksHint,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonalIcon(
              onPressed: () => context.go('/manage'),
              icon: const Icon(Icons.library_books_outlined),
              label: Text(l10n.manageLibrary),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _SettingsCard(
          title: l10n.debugInfo,
          subtitle: l10n.debugHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(l10n.platformTargets),
              const SizedBox(height: 8),
              Text(_environmentLabel(l10n, appConfig.environment)),
            ],
          ),
        ),
      ],
    );
  }

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return l10n.followSystem;
      case AppThemeMode.light:
        return l10n.lightMode;
      case AppThemeMode.dark:
        return l10n.darkMode;
    }
  }

  String _localeLabel(AppLocalizations l10n, AppLocaleMode mode) {
    switch (mode) {
      case AppLocaleMode.system:
        return l10n.followSystem;
      case AppLocaleMode.zhCn:
        return '简体中文';
      case AppLocaleMode.enUs:
        return 'English';
    }
  }

  String _environmentLabel(AppLocalizations l10n, AppEnv env) {
    switch (env) {
      case AppEnv.development:
        return l10n.environmentDevelopment;
      case AppEnv.staging:
        return l10n.environmentStaging;
      case AppEnv.production:
        return l10n.environmentProduction;
    }
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _ScrollableSegmentedButton<T> extends StatelessWidget {
  const _ScrollableSegmentedButton({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: child,
    );
  }
}
