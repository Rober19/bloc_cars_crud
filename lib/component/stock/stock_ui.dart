import 'dart:convert' show json;

import 'package:bloc_app/component/stock/cubit/stock_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'cubit/stock_cubit.dart';

class StockUI extends StatefulWidget {
  StockUI({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _StockUI createState() => _StockUI();
}

class _StockUI extends State<StockUI> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.finnhub.io?token=c3rdsk2ad3i88nmlpvk0'),
  );

  @override
  Widget build(BuildContext context) {
    dynamic prevValue = false;

    testInit();
    test(channel, context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '...',
            ),
            // BlocConsumer = BlocListener + BlocBuilder
            BlocConsumer<StockCubit, StockState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text('Incremented!'),
                  //     duration: Duration(milliseconds: 300),
                  //   ),
                  // );
                } else if (state.wasIncremented == false) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text('Decremented!'),
                  //     duration: Duration(milliseconds: 300),
                  //   ),
                  // );
                }
              },
              builder: (context, state) {
                dynamic counterValue = state.counterValue;

                bool wasIncremented = false;

                if (prevValue is bool)
                  prevValue = counterValue;
                else if (prevValue < counterValue) wasIncremented = true;

                prevValue = counterValue;

                // return Text(
                //   ' Stock : ' + counterValue.toString(),
                //   style: TextStyle(color: Colors.blueAccent, fontSize: 50),
                // );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Stock : ' + counterValue.toString(),
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    (wasIncremented)
                        ? Icon(
                            Icons.arrow_drop_up,
                            size: 80,
                            color: Colors.greenAccent[700],
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            size: 80,
                            color: Colors.redAccent[700],
                          ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    print('dispose');
    testClose(channel);
    super.dispose();
  }

  testInit() {
    channel.sink.add(json.encode({"type": 'subscribe', "symbol": 'AAPL'}));
    // channel.sink
    //     .add(json.encode({"type": 'subscribe', "symbol": 'BINANCE:BTCUSDT'}));
    // channel.sink
    //     .add(json.encode({"type": 'subscribe', "symbol": 'IC MARKETS:1'}));
  }

  test(WebSocketChannel channel, context) {
    print('test');

    channel.stream.listen((message) {
      Map<String, dynamic> stock = json.decode(message);
      // channel.sink.add('received!');

      dynamic testv = double.tryParse('${stock['data']?[0]?['p']}') ?? 'NONE';

      // print(testv);

      if (testv != 'NONE') BlocProvider.of<StockCubit>(context).replace(testv);
    });
  }

  testClose(WebSocketChannel channel) {
    channel.sink.close(4001, 'Custom close reason.');
  }
}
