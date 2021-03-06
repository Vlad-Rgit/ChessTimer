import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/theme/dimensions.dart';
import 'package:flutter/material.dart';

class RoomList extends StatelessWidget {

  final List<Room> rooms;
  final Function(Room room) onRoomClicked;

  RoomList({this.rooms, this.onRoomClicked});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, int index) {
          final item = rooms[index];
          return _RoomElement(
            key: ObjectKey(item),
            room: item,
            onRoomClicked: onRoomClicked,
          );
        });
  }
}

class _RoomElement extends StatelessWidget {

  final Room room;
  final Function(Room room) onRoomClicked;

  _RoomElement({Key key, this.room, this.onRoomClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.borderRadius),
          onTap: () { onRoomClicked(room); },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.name,
                        style: textTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "${room.player1} & ${room.player2}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text("${room.timePlayer1 + room.timePlayer2} min"),
                )
              ],
            ),
          ),
        ),
    );
  }
}
