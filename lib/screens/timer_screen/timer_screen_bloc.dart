
import 'package:chess_timer/domain/data_sources/timer_data_source.dart';
import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/timer_screen/timer_screen_state.dart';
import 'package:kiwi/kiwi.dart';
import 'package:rxdart/rxdart.dart';

class TimerScreenBloc {

  BehaviorSubject<TimerScreenState> _state = BehaviorSubject();
  Stream<TimerScreenState> get state => _state.stream;

  TimerDataSource _timerDataSource;
  final Room room;

  TimerScreenBloc(this.room) {

    _timerDataSource = KiwiContainer().resolve<TimerDataSource>();

    _timerDataSource.gameInfos.listen((gameInfo) {
      _state.add(TimerScreenState.waitingUsers(gameInfo));
    });

    _state.add(TimerScreenState.waitingInitGameInfo());
  }

  void initGameInfo() {
    _timerDataSource.updateGameInfo(room.id);
  }

  Future<void> sendAcceptRequest(String playerName) {
    return _timerDataSource
        .acceptUser(room.id, playerName);
  }

}