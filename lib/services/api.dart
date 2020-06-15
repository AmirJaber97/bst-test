import 'dart:convert';
import 'dart:io';

import 'package:bsttest/app/config.dart';
import 'package:bsttest/app/locator.dart';
import 'package:bsttest/app/logger.dart';
import 'package:bsttest/caches/preferences.dart';
import 'package:bsttest/models/failure_model.dart';
import 'package:bsttest/models/login_model.dart';
import 'package:bsttest/models/signal_model.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:dio/dio.dart';

class Api {
  var logger = getLogger("Api");
  AppConfig config = locator<AppConfig>();
  String endpoint;
  Preferences preferences = locator<Preferences>();

  static BaseOptions options = BaseOptions(
    headers: <String, String>{
      'Content-Type': 'application/json',

    },
  );
  var dio = Dio(options);

  Api() {
    endpoint = config.apiUrl;
  }

  Future<String> authorize(LoginModel model) async {
    var response;
    var code;
    logger.i(
        "Lggging in to: $endpoint/api/Authentication/RequestMoblieCabinetApiToken");

    try {
      response = await dio.post(
          "$endpoint/api/Authentication/RequestMoblieCabinetApiToken",
          data: jsonEncode(model.toJson()));
      return response.data;
    } on SocketException {
      logger.e('Socket Exception - Throwing Fail');
      throw Failure('No Internet connection 😑');
    } on HttpException {
      logger.e('Http Exception - Throwing Fail');
      throw Failure("Couldn't find what you're looking for 😱", code: code);
    } on FormatException {
      logger.e('Format Exception - Throwing Fail');
      throw Failure("Bad response format 👎");
    } catch (e) {
      logger.e('unknown error: $e}');
      throw Failure("Something happened.. try again later");
    }
  }


  Future<List<SignalModel>> getSignals() async {
    var response;
    var code;
    List<SignalModel> signals = List<SignalModel>();
    logger.i(
        "Getting signals from: $endpoint/clientmobile/GetAnalyticSignals/20234561?tradingsystem=3&pairs=GBPJPY,EURJPY&from=1479860023&to=1480066860");

    logger.i("Token: ${preferences.token()}");

    try {
      response = await dio.get(
          "$endpoint/clientmobile/GetAnalyticSignals/20234561?tradingsystem=3&pairs=GBPJPY,EURJPY&from=1479860023&to=1480066860",
          options: Options(
            headers: {"passkey": "${preferences.token()}"},
          ));
          response.data.forEach((signal) => {
          signals.add(SignalModel.fromJson(signal))
          });
          return signals;

    } on SocketException {
      logger.e('Socket Exception - Throwing Fail');
      throw Failure('No Internet connection 😑');
    } on HttpException {
      logger.e('Http Exception - Throwing Fail');
      throw Failure("Couldn't find what you're looking for 😱", code: code);
    } on FormatException {
      logger.e('Format Exception - Throwing Fail');
      throw Failure("Bad response format 👎");
    } catch (e) {
      logger.e('unknown error: $e}');
      throw Failure("Something happened.. try again later");
    }
  }
}
