import 'dart:async';

import 'package:chess_timer/domain/data_sources/rooms_data_source.dart';
import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/screens/home_screen/home_intent.dart';
import 'package:chess_timer/screens/home_screen/home_state.dart';
import 'package:kiwi/kiwi.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  RoomsDataSource _roomsDataSource;
  BehaviorSubject<HomeState> _stateController = BehaviorSubject();
  Stream<HomeState> get state => _stateController.stream;
  BehaviorSubject<String> _queries = BehaviorSubject.seeded("");

  HomeBloc() {
    _roomsDataSource = KiwiContainer().resolve<RoomsDataSource>();
    _roomsDataSource.updateRooms();

    Rx.combineLatest(<Stream>[_queries.stream, _roomsDataSource.roomsStream],
        (values) {
      String query = values[0];
      List<Room> rooms = values[1];

      return rooms.where((room) => room.name.contains(query)).toList();
    }).listen((rooms) {
      _stateController.sink.add(HomeState.roomList(rooms));
    });
  }

  Future<void> handleIntent(HomeIntent intent) async {
    if (intent is RefreshHomeIntent) {
      await _roomsDataSource.updateRooms();
    } else if (intent is UpdateSearchQueryIntent) {
      _pushNewQuery(intent.newQuery);
    }
  }

  void _pushNewQuery(String newQuery) {
    _queries.sink.add(newQuery);
  }

  void dispose() {
    _stateController.close();
  }
}
