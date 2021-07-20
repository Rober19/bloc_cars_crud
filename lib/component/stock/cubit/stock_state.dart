part of 'stock_cubit.dart';

class StockState {
  int? counterValue;
  bool? wasIncremented;

  StockState({
    this.counterValue,
    this.wasIncremented,
  }) {
    // Socket _socket = io(
    //   'wss://ws.finnhub.io?token=c3rdsk2ad3i88nmlpvk0',
    //   OptionBuilder()
    //       .setTransports(['websocket'])
    //       .setTimeout(3000)
    //       .disableAutoConnect()
    //       .disableReconnection()
    //       .build(),
    // );
    // _socket.on('message', (data) => print(data));
  }
}
