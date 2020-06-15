import 'package:bsttest/app/config.dart';
import 'package:bsttest/app/locator.dart';
import 'package:bsttest/app/logger.dart';
import 'package:bsttest/caches/preferences.dart';
import 'package:bsttest/constants/app_strings.dart';
import 'package:bsttest/ui/routes.dart';
import 'package:bsttest/ui/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

final logger = getLogger('Main');

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (env == null) env = 'prod';
  // init logger
  Logger.level = Level.info;
  // init locator (DI)
  setupLocator();
  // init hive (cache)
  await Hive.initFlutter();
  await locator<Preferences>().openBox();
  // init config setup
  AppConfig config = locator<AppConfig>();
  await config.forEnvironment(env);
  // ensure orientation is portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // run app
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: Routes.generateRoute,
home: Scaffold(
  body: LoginView(),
),
    );
  }
}
