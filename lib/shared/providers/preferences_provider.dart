import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/preferences_service.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  throw UnimplementedError('启动阶段必须覆盖 PreferencesService');
});
