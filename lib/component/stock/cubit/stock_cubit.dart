import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit() : super(StockState(counterValue: 0));

  

  void increment() => emit(StockState(
      counterValue: (state.counterValue as double) + 1, wasIncremented: true));

  void decrement() => emit(StockState(
      counterValue: (state.counterValue as double) - 1, wasIncremented: false));

  void replace(double value) => emit(StockState(counterValue: value));
}
