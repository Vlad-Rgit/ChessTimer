import 'package:chess_timer/domain/models/GameInfo.dart';
import 'package:flutter/cupertino.dart';

abstract class TimerDataSource {

  Stream<GameInfo> get gameInfos;

  Future<void> updateGameInfo(int roomId);
  Future<void> acceptUser(int roomId, String playerName);
}