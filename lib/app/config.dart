import 'dart:convert';

import 'package:bsttest/app/logger.dart';
import 'package:flutter/services.dart';

class AppConfig {
  String apiUrl;
  bool isDev;
  var logger = getLogger('AppConfig');

  Future forEnvironment(String env) async {
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    final json = jsonDecode(contents);
    apiUrl = json['apiUrl'];
    logger.i('Using API URL: $apiUrl');
    isDev = env == 'dev';
  }
}
