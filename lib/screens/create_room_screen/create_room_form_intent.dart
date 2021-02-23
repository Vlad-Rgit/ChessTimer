import 'package:chess_timer/domain/models/room.dart';

abstract class CreateRoomFormIntent {
  factory CreateRoomFormIntent.createRoom(Room room) {
    return CreateRoomIntent(room);
  }
}

class CreateRoomIntent implements CreateRoomFormIntent {
  final Room room;
  const CreateRoomIntent(this.room);
}
