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
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(16)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) =>
                  _bloc.handleIntent(HomeIntent.updateSearchQuery(value)),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search by room name",
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: RoomsHost(
              state: _state,
              onCreateClicked: () {
                _navigateToCreateRoom();
              },
              onRefreshClicked: () async {
                await _bloc.handleIntent(HomeIntent.refresh());
              },
            ),
          ),
        ],
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
