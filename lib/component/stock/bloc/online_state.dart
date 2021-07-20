part of 'online_bloc.dart';

@immutable
abstract class OnlineState {}

class OnlineInitialState extends OnlineState {}

class OnlineConnectingState extends OnlineState {}

class OnlineJoiningState extends OnlineState {}
class OnlineJoinedState extends OnlineState {}
class OnlineConnectedState extends OnlineState {}
class OnlineConnectErrorState extends OnlineState {}
class OnlineConnectTimeoutState extends OnlineState {}
class OnlineDisconnectedState extends OnlineState {}
class OnlineErrorState extends OnlineState {}
