import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/domain/models/server_response.dart';

abstract class RoomsDataSource {
  Stream<List<Room>> get roomsStream;

  Future<void> updateRooms();
  Future<ServerResponse> postRoom(Room room);
  void dispose();
}
