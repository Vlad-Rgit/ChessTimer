import 'package:chess_timer/domain/models/room.dart';
import 'package:flutter/cupertino.dart';

class HomeState {
  factory HomeState.loading() => LoadingHomeState();
  factory HomeState.roomList(List<Room> rooms) =>
      RoomsListHomeState(rooms: rooms);
}

class LoadingHomeState implements HomeState {}

class RoomsListHomeState implements HomeState {
  final List<Room> rooms;

  const RoomsListHomeState({@required this.rooms});
}
