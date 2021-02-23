import 'package:chess_timer/domain/models/server_response.dart';

abstract class CreateRoomState {
  factory CreateRoomState.init() => CreateRoomInitState();
  factory CreateRoomState.createResult(ServerResponse response) {
    return CreateResult(response);
  }
  factory CreateRoomState.loading() => CreateRoomLoadingState();
}

class CreateRoomInitState implements CreateRoomState {}

class CreateResult implements CreateRoomState {
  final ServerResponse response;

  const CreateResult(this.response);
}

class CreateRoomLoadingState implements CreateRoomState {}
