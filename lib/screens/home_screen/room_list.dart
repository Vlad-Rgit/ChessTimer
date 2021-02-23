import 'package:chess_timer/domain/models/room.dart';
import 'package:flutter/material.dart';

class RoomList extends StatelessWidget {
  final List<Room> rooms;

  RoomList({this.rooms});

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
          );
        });
  }
}

class _RoomElement extends StatelessWidget {
  final Room room;

  _RoomElement({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          room.name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}