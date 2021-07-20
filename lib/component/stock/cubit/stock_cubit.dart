import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
// import 'package:socket_io_client/socket_io_client.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit() : super(StockState(counterValue: 0));

  void increment() => emit(StockState(
      counterValue: (state.counterValue as int) + 1, wasIncremented: true));

  void decrement() => emit(StockState(
      counterValue: (state.counterValue as int) - 1, wasIncremented: false));

  void replace(int value) => emit(StockState(counterValue: value));
}
