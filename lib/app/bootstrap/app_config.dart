import 'app_env.dart';

class AppConfig {
  const AppConfig({
    required this.appName,
    required this.environment,
  });

  final String appName;
  final AppEnv environment;
}
