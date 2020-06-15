import 'package:bsttest/app/locator.dart';
import 'package:bsttest/enums/notifier_state.dart';
import 'package:bsttest/services/api.dart';
import 'package:bsttest/ui/app_base_widget.dart';
import 'package:bsttest/ui/views/signals/components/signal_card.dart';
import 'package:bsttest/ui/views/signals/signals_viewmodel.dart';
import 'package:flutter/material.dart';

class SignalsView extends StatefulWidget {
  @override
  _SignalsViewState createState() => _SignalsViewState();
}

class _SignalsViewState extends State<SignalsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<SignalsViewModel>(
          viewModel: SignalsViewModel(api: locator<Api>()),
          onViewModelReady: (viewModel) => viewModel.getSignals(),
          builder: (_, model, __) {
            return model.state == NotifierState.Loaded
                ? model.failure == null
                    ? ListView.builder(
                        itemCount: model.clientSignals.length,
                        itemBuilder: (context, index) {
                          return SignalCard(signal: model.clientSignals[index],);
                        })
                    : Center(
                        child:
                            Container(child: Text('${model.failure.message}')))
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
