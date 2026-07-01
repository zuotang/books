import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

enum LibrarySortMode {
  recentRead,
  title,
  author,
}

final initialLibrarySortModeProvider = Provider<LibrarySortMode>((ref) {
  return LibrarySortMode.recentRead;
});

final librarySortModeProvider =
    StateNotifierProvider<LibrarySortModeController, LibrarySortMode>((ref) {
  final initialMode = ref.watch(initialLibrarySortModeProvider);
  final service = ref.watch(preferencesServiceProvider);
  return LibrarySortModeController(
    initialMode: initialMode,
    onChanged: service.saveLibrarySortMode,
  );
});

class LibrarySortModeController extends StateNotifier<LibrarySortMode> {
  LibrarySortModeController({
    required LibrarySortMode initialMode,
    required this.onChanged,
  }) : super(initialMode);

  final Future<void> Function(LibrarySortMode mode) onChanged;

  Future<void> update(LibrarySortMode mode) async {
    if (state == mode) {
      return;
    }

    state = mode;
    await onChanged(mode);
  }
}
