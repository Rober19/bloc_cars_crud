import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'online_event.dart';
part 'online_state.dart';

class OnlineBloc extends Bloc<OnlineEvent, OnlineState> {
  late final Socket _socket;

  OnlineBloc(
      [String address = 'wss://ws.finnhub.io?token=c3rdsk2ad3i88nmlpvk0'])
      : super(OnlineInitialState()) {
    _socket = io(
      address,
      OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );   
    _socket.on('message', (data) => print(data));
  }

  @override
  Stream<OnlineState> mapEventToState(OnlineEvent event) async* {
    if (event is OnlineConnectEvent) {
      yield OnlineConnectingState();
      _socket.connect();
    } else if (event is OnlineJoinEvent) {
      yield OnlineJoiningState();
      _socket.emit('join');
    } else if (event is _OnlineJoinedEvent) {
      yield OnlineJoinedState(
          // roomId: event.roomId,
          // opponentIds: event.opponentIds,
          );
    } else if (event is _OnlineConnectingEvent) {
      yield OnlineConnectingState();
    } else if (event is _OnlineConnectedEvent) {
      yield OnlineConnectedState();
    } else if (event is _OnlineConnectErrorEvent) {
      yield OnlineConnectErrorState();
    } else if (event is _OnlineConnectTimeoutEvent) {
      yield OnlineConnectTimeoutState();
    } else if (event is _OnlineDisconnectEvent) {
      yield OnlineDisconnectedState();
    } else if (event is _OnlineErrorEvent) {
      yield OnlineErrorState();
    }
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}
