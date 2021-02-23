import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_screen.dart';
import 'package:chess_timer/screens/home_screen/home_bloc.dart';
import 'package:chess_timer/screens/home_screen/home_intent.dart';
import 'package:chess_timer/screens/home_screen/home_state.dart';
import 'package:chess_timer/screens/home_screen/rooms_host.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;
  HomeState _state = HomeState.loading();

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc();
    _bloc.state.listen((event) {
      setState(() {
        _state = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chess Timer")),
      body: RoomsHost(
        state: _state,
        onCreateClicked: () {
          _navigateToCreateRoom();
        },
        onRefreshClicked: () async {
          await _bloc.handleIntent(HomeIntent.refresh());
        },
      ),
    );
  }

  Future<void> _navigateToCreateRoom() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CreateRoomScreen();
    }));
    _bloc.handleIntent(HomeIntent.refresh());
  }
}
