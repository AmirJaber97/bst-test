import 'package:bsttest/models/signal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalCard extends StatefulWidget {
  final SignalModel signal;

  const SignalCard({Key key, this.signal})
      : super(key: key);

  @override
  _SignalCardState createState() => _SignalCardState();
}

class _SignalCardState extends State<SignalCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Get.defaultDialog(title: 'Info',middleText: 'You opened ID ${widget.signal.id}')},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 165.0,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        'Price: ${widget.signal.price}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Actual time in ms: ${widget.signal.actualTime}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                        'Comment: ${widget.signal.comment ?? ''}'),
                                    Text('Pair: ${widget.signal.pair ?? ''}'),
                                    Text(
                                        'Period: ${widget.signal.period ?? 'NA'}'),
                                    Text('SL: ${widget.signal.sl ?? 'NA'}'),
                                    Text('TP: ${widget.signal.sl ?? 'NA'}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text('ID: ${widget.signal.id}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                        'Trading system: ${widget.signal.tradingSystem}'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('CMD: ${widget.signal.cmd}'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
