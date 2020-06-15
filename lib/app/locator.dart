import 'package:bsttest/app/config.dart';
import 'package:bsttest/caches/preferences.dart';
import 'package:bsttest/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AppConfig());
  locator.registerLazySingleton(() => Preferences());
}
