import 'package:bsttest/app/locator.dart';
import 'package:bsttest/app/logger.dart';
import 'package:bsttest/caches/preferences.dart';
import 'package:bsttest/enums/notifier_state.dart';
import 'package:bsttest/models/failure_model.dart';
import 'package:bsttest/models/signal_model.dart';
import 'package:bsttest/services/api.dart';
import 'package:bsttest/ui/app_base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalsViewModel extends BaseModel {
  var logger = getLogger("SignalsViewModel");
  Api _api;
  Preferences preferences = locator<Preferences>();

  Either<Failure, List<SignalModel>> _signals;

  Either<Failure, List<SignalModel>> get signals => _signals;

  List<SignalModel> clientSignals;
  Failure failure;


  SignalsViewModel({
    @required Api api,
  }) : _api = api;

  Future getSignals() async {
    setNotifier(NotifierState.Loading);
    await Task(() => _api.getSignals())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) {
      _signals = value;
      _signals.fold((fail) {
        failure = fail;
      }, (signals) => clientSignals = signals);
      if(failure != null) {
        Get.snackbar("Ooops", "${failure.message}");
      } else{
        setNotifier(NotifierState.Loaded);
      }
    });
    setNotifier(NotifierState.Loaded);
  }
}
