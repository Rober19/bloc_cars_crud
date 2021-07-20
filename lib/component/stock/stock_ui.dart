import 'package:bloc_app/component/stock/cubit/stock_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/stock_cubit.dart';

class StockUI extends StatefulWidget {
  StockUI({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _StockUI createState() => _StockUI();
}

class _StockUI extends State<StockUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
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
}
