import 'package:bsttest/app/locator.dart';
import 'package:bsttest/app/logger.dart';
import 'package:bsttest/caches/preferences.dart';
import 'package:bsttest/constants/app_routes.dart';
import 'package:bsttest/enums/notifier_state.dart';
import 'package:bsttest/models/failure_model.dart';
import 'package:bsttest/models/login_model.dart';
import 'package:bsttest/services/api.dart';
import 'package:bsttest/ui/app_base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends BaseModel {
  var logger = getLogger("LoginViewModel");
  Api _api;
  Preferences preferences = locator<Preferences>();

  LoginViewModel({
    @required Api api,
  }) : _api = api;

  Either<Failure, String> _token;

  Either<Failure, String> get token => _token;

  Future authorize(String login, String password) async {
    setNotifier(NotifierState.Loading);
    LoginModel model = LoginModel();
    model.login = login.isEmpty ? '20234561' : login;
    model.password = password.isEmpty ? 'ladevi31': password;
    await Task(() => _api.authorize(model))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) {
      logger.i("Here");
      _token = value;
      Failure failure;
      token.fold((fail) {
        logger.i("Failure is $fail");
        failure = fail;
      }, (token) => preferences.setToken(token));
      if (failure != null) {
        Get.snackbar("Ooops", "Wrong credentials");
      } else {
        Get.toNamed(RoutePaths.Signals);
        setNotifier(NotifierState.Loaded);
      }
    });
    setNotifier(NotifierState.Loaded);
  }
}
