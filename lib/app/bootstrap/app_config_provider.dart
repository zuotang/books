import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_config.dart';

// 启动时注入当前环境配置。
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('启动阶段必须覆盖 AppConfig');
});
