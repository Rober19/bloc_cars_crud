part of 'online_bloc.dart';

@immutable
abstract class OnlineEvent {}

class _OnlineConnectingEvent extends OnlineEvent {}

class _OnlineConnectedEvent extends OnlineEvent {}

class _OnlineConnectErrorEvent extends OnlineEvent {}

class _OnlineConnectTimeoutEvent extends OnlineEvent {}

class _OnlineDisconnectEvent extends OnlineEvent {}

class _OnlineErrorEvent extends OnlineEvent {}

class _OnlineJoinedEvent extends OnlineEvent {
  _OnlineJoinedEvent.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() => {};
}

class OnlineConnectEvent extends OnlineEvent {}

class OnlineJoinEvent extends OnlineEvent {}
