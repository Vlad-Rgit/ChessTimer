import 'package:chess_timer/domain/data_sources/rooms_data_source.dart';
import 'package:chess_timer/framework/data_sources/api_rooms_data_source.dart';
import 'package:kiwi/kiwi.dart';

void registerDependencies() {
  final container = KiwiContainer();
  _registerDataSources(container);
}

void _registerDataSources(KiwiContainer container) {
  container
      .registerSingleton<RoomsDataSource>((container) => ApiRoomsDataSource());
}
