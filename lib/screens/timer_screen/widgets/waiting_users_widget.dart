import 'package:chess_timer/domain/models/GameInfo.dart';
import 'package:chess_timer/domain/models/room.dart';
import 'package:flutter/material.dart';

class WaitingUsersWidget extends StatelessWidget {

  final GameInfo gameInfo;
  final Room room;

  final Function(String playerName) onAcceptClicked;

  WaitingUsersWidget({@required this.gameInfo, @required this.room, @required this.onAcceptClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          RaisedButton(onPressed: !gameInfo.is1UserAccepted ? () {
            onAcceptClicked(room.player1);
          } : null,
            child: Text("Start as " + room.player1),
          ),
          RaisedButton(onPressed: !gameInfo.is2UserAccepted ? () {
            onAcceptClicked(room.player2);
          } : null,
              child: Text("Start as " + room.player2)),
        ],
      )],
    );
  }
}
