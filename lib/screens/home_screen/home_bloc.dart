import 'dart:async';

import 'package:chess_timer/domain/data_sources/rooms_data_source.dart';
import 'package:chess_timer/screens/home_screen/home_intent.dart';
import 'package:chess_timer/screens/home_screen/home_state.dart';
import 'package:kiwi/kiwi.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  RoomsDataSource _roomsDataSource;
  BehaviorSubject<HomeState> _stateController = BehaviorSubject();
  Stream<HomeState> get state => _stateController.stream;

  HomeBloc() {
    _roomsDataSource = KiwiContainer().resolve<RoomsDataSource>();
    _roomsDataSource.updateRooms();
    _roomsDataSource.roomsStream.listen((event) {
      _stateController.sink.add(HomeState.roomList(event));
    });
  }

  Future<void> handleIntent(HomeIntent intent) async {
    if (intent is RefreshHomeIntent) {
      await _roomsDataSource.updateRooms();
    }
  }

  void dispose() {
    _stateController.close();
  }
}
