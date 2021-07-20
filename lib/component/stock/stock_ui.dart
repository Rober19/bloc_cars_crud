import 'dart:convert';

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

                return Text(
                  ' Stock : ' + counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    BlocProvider.of<StockCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} #2'),
                  onPressed: () {
                    BlocProvider.of<StockCubit>(context).increment();
                    // context.bloc<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    test_close(channel);
    super.dispose();
  }

  test(WebSocketChannel channel, context) {
    print('test');

    final jsonEncoder = JsonEncoder();

    channel.sink
        .add(jsonEncoder.convert({"type": 'subscribe', "symbol": 'AAPL'}));
    channel.sink.add(jsonEncoder
        .convert({"type": 'subscribe', "symbol": 'BINANCE:BTCUSDT'}));
    channel.sink.add(
        jsonEncoder.convert({"type": 'subscribe', "symbol": 'IC MARKETS:1'}));

    channel.stream.listen((message) {
      Map<String, dynamic> stock = jsonDecode(message);
      // channel.sink.add('received!');

      dynamic testv = double.tryParse('${stock['data'][0]['p']}') ?? 'NONE';

      if (testv != 'NONE') BlocProvider.of<StockCubit>(context).replace(testv);
      // channel.sink.close(status.goingAway);
    });
  }

  test_close(WebSocketChannel channel) {
    channel.sink.close(status.goingAway);
  }
}
