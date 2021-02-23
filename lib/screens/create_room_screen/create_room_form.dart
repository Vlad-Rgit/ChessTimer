import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/theme/colors.dart';
import 'package:chess_timer/widgets/chip_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final _timePlays = const [3, 5, 10, 15];
  final _addTimes = const [1, 3, 5, 10, 15];

  TextEditingController _roomNameController;

  var _selectedTimePlayIndex = 0;
  var _selectedAddTimeIndex = 0;

  int _player1time;
  int _player2time;

  var _roomNameError = false;

  @override
  void initState() {
    _roomNameController = TextEditingController();
    _player1time = _timePlays[_selectedTimePlayIndex];
    _player2time = _timePlays[_selectedTimePlayIndex];
    super.initState();
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  void _updateSelectedTimePlayIndex(int index) {
    setState(() {
      _selectedTimePlayIndex = index;
      _player1time = _timePlays[_selectedTimePlayIndex];
      _player2time = _timePlays[_selectedTimePlayIndex];
    });
  }

  void _updateSelectedAddTimeIndex(int index) {
    setState(() {
      _selectedAddTimeIndex = index;
    });
  }

  void _updatePlayersTime(int player1Time, int player2Time) {
    setState(() {
      _player1time = player1Time;
      _player2time = player2Time;
    });
  }

  void _submit() {
    if (_roomNameController.text.isEmpty) {
      setState(() {
        _roomNameError = true;
      });
      return;
    }

    widget.onSubmitClicked(Room(0, _roomNameController.text, "", "",
        _player1time, _player2time, _addTimes[_selectedAddTimeIndex]));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _roomNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Room name",
                errorText: _roomNameError ? "Room name cannot be empty" : null),
            cursorColor: Palette.cursorColor,
          ),
          Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                "Time play (minutes)",
                style: theme.textTheme.subtitle1,
              )),
          ChipList(
              items: _timePlays,
              onSelectionChanged: (index, value) =>
                  _updateSelectedTimePlayIndex(index),
              selectedIndex: _selectedTimePlayIndex),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              "Add time",
              style: theme.textTheme.subtitle1,
            ),
          ),
          ChipList(
            items: _addTimes,
            onSelectionChanged: (index, value) =>
                _updateSelectedAddTimeIndex(index),
            selectedIndex: _selectedAddTimeIndex,
            labelFormat: (value) => "+" + value.toString(),
          ),
          PlayerTimeContainer(
              label: "Player 1 time",
              value: _player1time,
              reduce: () {
                _updatePlayersTime(_player1time - 1, _player2time);
              },
              inc: () {
                _updatePlayersTime(_player1time + 1, _player2time);
              }),
          PlayerTimeContainer(
              label: "Player 2 time",
              value: _player2time,
              reduce: () {
                _updatePlayersTime(_player1time, _player2time - 1);
              },
              inc: () {
                _updatePlayersTime(_player1time, _player2time + 1);
              }),
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
    );
  }
}

class PlayerTimeContainer extends StatelessWidget {
  final Function reduce;
  final Function inc;
  final int value;
  final String label;

  PlayerTimeContainer(
      {@required this.value,
      @required this.reduce,
      @required this.inc,
      @required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          Text(
            label,
            style: theme.textTheme.subtitle1,
          ),
          RaisedButton(
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              shape: CircleBorder(),
              onPressed: reduce),
          Text(
            value.toString(),
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
