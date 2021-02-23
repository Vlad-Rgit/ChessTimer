import 'package:chess_timer/domain/data_sources/rooms_data_source.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_form_intent.dart';
import 'package:chess_timer/screens/create_room_screen/create_room_state.dart';
import 'package:kiwi/kiwi.dart';
import 'package:rxdart/rxdart.dart';

class CreateRoomBloc {
  RoomsDataSource _roomsDataSource;

  BehaviorSubject<CreateRoomState> _state;

  Stream<CreateRoomState> get state => _state.stream;

  CreateRoomBloc() {
    _state = BehaviorSubject();
    _roomsDataSource = KiwiContainer().resolve<RoomsDataSource>();
  }

  Future<void> handleIntent(CreateRoomFormIntent intent) async {
    if (intent is CreateRoomIntent) {
      _state.sink.add(CreateRoomState.loading());
      final response = await _roomsDataSource.postRoom(intent.room);
      _state.sink.add(CreateRoomState.createResult(response));
    }
  }
}
