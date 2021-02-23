import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_bloc.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_form.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_form_intent.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_state.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateRoomState();
  }
}

class _CreateRoomState extends State<CreateRoomScreen> {
  final _bloc = CreateRoomBloc();
  var _state = CreateRoomState.init();

  @override
  void initState() {
    super.initState();
    _bloc.state.listen((event) {
      if (event is CreateResult) {
        if (event.response.responseCode == 200) {
          Navigator.pop(context);
          return;
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Some error occured")));
        }
      }

      setState(() {
        _state = event;
      });
    });
  }

  void _submit(Room room) {
    _bloc.handleIntent(CreateRoomFormIntent.createRoom(room));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create room"),
      ),
      body: SingleChildScrollView(
        child: CreateRoomForm(
          onSubmitClicked: _submit,
          isLoading: _state is CreateRoomLoadingState,
        ),
      ),
    );
  }
}
