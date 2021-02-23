import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/home_screen/home_state.dart';
import 'package:chess_timer/screens/home_screen/room_list.dart';
import 'package:chess_timer/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoomsHost extends StatelessWidget {
  final HomeState state;
  final Function onCreateClicked;
  final AsyncCallback onRefreshClicked;

  RoomsHost({
    @required this.state,
    @required this.onCreateClicked,
    @required this.onRefreshClicked,
  });

  Widget _buildBody(HomeState state) {
    print("Received state");
    if (state is LoadingHomeState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is RoomsListHomeState) {
      return RefreshIndicator(
          child: RoomList(rooms: state.rooms), onRefresh: onRefreshClicked);
    } else {
      return Text("Unknown state");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _buildBody(state)),
        Container(
          margin: EdgeInsets.all(16.0),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: onCreateClicked,
            child: Text("Create room"),
          ),
        )
      ],
    );
  }
}
