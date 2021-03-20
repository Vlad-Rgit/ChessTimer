import 'dart:math';

import 'package:chess_timer/config.dart';
import 'package:chess_timer/domain/data_sources/timer_data_source.dart';
import 'package:chess_timer/domain/models/GameInfo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRTimerDataSource implements TimerDataSource {

  final connection = HubConnectionBuilder().withUrl(Config.apiAddress + "/timerHub",
      HttpConnectionOptions(
        logging: (level, message) => print(message),
      )).build();
  
  bool _isConnected = false;

  final BehaviorSubject<GameInfo> _gameInfosSubject = BehaviorSubject();

  @override
  Stream<GameInfo> get gameInfos => _gameInfosSubject.stream;


  SignalRTimerDataSource() {

    connection.on("usersAccepted", (arguments) {
      _gameInfosSubject.add(GameInfo(arguments[0], arguments[1]));
    });

    connection.on("failure", (arguments) {
      print("Timer hub failure: " + arguments[0]);
    });
  }

  @override
  Future<void> updateGameInfo(int roomId) async {

    await ensureConnectionEstablished();

    connection.invoke("GetInfo", args: [roomId]);
  }
  
  Future<void> ensureConnectionEstablished() async {
    if(!_isConnected) {
      await connection.start();
      _isConnected = true;
    }
  }

  @override
  Future<void> acceptUser(int roomId, String playerName) async {
    await ensureConnectionEstablished();

    connection.invoke("SendInit", args: [roomId, playerName]);
  }

}