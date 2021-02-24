import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/theme/colors.dart';
import 'package:chess_timer/widgets/chip_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomFormModel {
  static final timePlays = const [3, 5, 10, 15];
  static final addTimes = const [1, 3, 5, 10, 15];

  String roomName = "";
  int player1TimePlayIndex = 0;
  int player2TimePlayIndex = 0;
  int player1TimePlay;
  int player2TimePlay;
  int addTime = 1;
  String player1Name = "";
  String player2Name = "";

  RoomFormModel() {
    player1TimePlay = timePlays[player1TimePlayIndex];
    player2TimePlay = timePlays[player2TimePlayIndex];
  }

  Room toDomain() => Room(0, roomName, player1Name, player2Name,
      player1TimePlay, player2TimePlay, addTime);
}

class CreateRoomForm extends StatefulWidget {
  final Function(Room room) onSubmitClicked;
  final bool isLoading;

  CreateRoomForm({@required this.onSubmitClicked, @required this.isLoading});

  @override
  _CreateRoomFormState createState() {
    return _CreateRoomFormState();
  }
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  var roomFormModel = RoomFormModel();

  final _formKey = GlobalKey<FormState>();
  final _player1Key = GlobalKey<FormFieldState>();
  final _player2Key = GlobalKey<FormFieldState>();

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSubmitClicked(roomFormModel.toDomain());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Room name"),
              cursorColor: Palette.cursorColor,
              onSaved: (value) => roomFormModel.roomName = value,
              validator: (value) =>
                  value.isEmpty ? "Room name is required" : null,
            ),
            Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  "Time play (minutes)",
                  style: theme.textTheme.subtitle1,
                )),
            ChipList(
                items: RoomFormModel.timePlays,
                onSelectionChanged: (index, value) {
                  setState(() {
                    roomFormModel.player1TimePlay = value;
                    roomFormModel.player2TimePlay = value;
                    roomFormModel.player1TimePlayIndex = index;
                    roomFormModel.player2TimePlayIndex = index;
                  });
                }),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                "Add time (seconds)",
                style: theme.textTheme.subtitle1,
              ),
            ),
            ChipList(
              items: RoomFormModel.addTimes,
              onSelectionChanged: (index, value) {
                roomFormModel.addTime = value;
              },
              labelFormat: (value) => "+" + value.toString(),
            ),
            PlayerTimeContainer(
              textFormKey: _player1Key,
              initialValue: "Player 1",
              time: roomFormModel.player1TimePlay,
              reduce: () {
                setState(() {
                  roomFormModel.player1TimePlay -= 1;
                });
              },
              inc: () {
                setState(() {
                  roomFormModel.player1TimePlay += 1;
                });
              },
              onSave: (value) => roomFormModel.player1Name = value,
              validator: (value) {
                String player2Name = _player2Key.currentState.value;
                if (value == player2Name) {
                  return "Players name must differ";
                } else {
                  return null;
                }
              },
            ),
            PlayerTimeContainer(
              textFormKey: _player2Key,
              initialValue: "Player 2",
              time: roomFormModel.player2TimePlay,
              reduce: () {
                setState(() {
                  roomFormModel.player2TimePlay -= 1;
                });
              },
              inc: () {
                setState(() {
                  roomFormModel.player2TimePlay += 1;
                });
              },
              onSave: (value) => roomFormModel.player2Name = value,
              validator: (value) {
                String player1Name = _player1Key.currentState.value;
                if (player1Name == value) {
                  return "Players name must differ";
                } else {
                  return null;
                }
              },
            ),
            widget.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RaisedButton(
                    onPressed: _submit,
                    child: Text("Submit"),
                  )
          ],
        ),
      ),
    );
  }
}

class PlayerTimeContainer extends StatelessWidget {
  final Function reduce;
  final Function inc;
  final int time;
  final GlobalKey textFormKey;
  final Function(String) onSave;
  final String Function(String) validator;
  final String initialValue;

  PlayerTimeContainer(
      {@required this.time,
      @required this.reduce,
      @required this.inc,
      @required this.textFormKey,
      @required this.onSave,
      @required this.validator,
      @required this.initialValue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              key: textFormKey,
              style: theme.textTheme.subtitle1,
              onSaved: onSave,
              validator: this.validator,
              controller: TextEditingController()..text = initialValue,
              decoration: InputDecoration(border: OutlineInputBorder()),
              cursorColor: Palette.cursorColor,
            ),
          ),
          RaisedButton(
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              shape: CircleBorder(),
              onPressed: reduce),
          Text(
            time.toString(),
            style: theme.textTheme.bodyText1,
          ),
          RaisedButton(
            onPressed: inc,
            child: Text("+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}
