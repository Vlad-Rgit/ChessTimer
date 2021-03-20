

import 'package:chess_timer/domain/models/GameInfo.dart';
import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/timer_screen/timer_screen_bloc.dart';
import 'package:chess_timer/screens/timer_screen/timer_screen_state.dart';
import 'package:chess_timer/screens/timer_screen/widgets/waiting_users_widget.dart';
import 'package:flutter/material.dart';


class TimerScreen extends StatefulWidget {

  final Room room;

  TimerScreen({@required this.room});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  TimerScreenState _state;
  TimerScreenBloc _bloc;


  @override
  void initState() {

    _state = TimerScreenState.waitingInitGameInfo();
    _bloc = TimerScreenBloc(widget.room);

    _bloc.state.listen((newState) {
      setState(() {
        _state = newState;
      });
    });

    _bloc.initGameInfo();
  }

  Widget _buildBody() {
    if(_state is WaitingInitGameInfo) {
      return WaitingUsersWidget(
        gameInfo: GameInfo(false, false),
        room: widget.room,
      );
    }
    else if(_state is WaitingUsersState) {
      WaitingUsersState info = _state as WaitingUsersState;
      return WaitingUsersWidget(
        gameInfo: info.gameInfo,
        room: widget.room,
        onAcceptClicked: (name) {
          _bloc.sendAcceptRequest(name);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Room - " + widget.room.name
        ),
      ),
      body: _buildBody(),
    );
  }
}
