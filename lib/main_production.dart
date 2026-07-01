import 'app/bootstrap/app_config.dart';
import 'app/bootstrap/app_env.dart';
import 'app/bootstrap/bootstrap.dart';

void main() {
  bootstrap(
    config: const AppConfig(
      appName: 'Book App',
      environment: AppEnv.production,
    ),
  );
}
