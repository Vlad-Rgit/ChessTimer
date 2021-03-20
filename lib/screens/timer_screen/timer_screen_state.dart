
import 'package:chess_timer/domain/models/GameInfo.dart';

abstract class TimerScreenState {

  TimerScreenState();

  factory TimerScreenState.waitingInitGameInfo() {
    return WaitingInitGameInfo();
  }

  factory TimerScreenState.waitingUsers(GameInfo info) {
    return WaitingUsersState(info);
  }

}

class WaitingInitGameInfo extends TimerScreenState {}

class WaitingUsersState extends TimerScreenState {

  final GameInfo gameInfo;

  WaitingUsersState(this.gameInfo);
}