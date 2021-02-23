import 'dart:async';
import 'dart:convert';

import 'package:chess_timer/config.dart';
import 'package:chess_timer/domain/data_sources/rooms_data_source.dart';
import 'package:chess_timer/domain/models/room.dart';
import 'package:chess_timer/domain/models/server_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class ApiRoomsDataSource implements RoomsDataSource {
  BehaviorSubject<List<Room>> _roomsStreamController = BehaviorSubject();

  @override
  Stream<List<Room>> get roomsStream => _roomsStreamController.stream;

  @override
  Future<void> updateRooms() async {
    final response = await http.get(Config.apiAddress + "/ApiRoom");
    _roomsStreamController.sink.add(_parseRooms(response.body));
  }

  List<Room> _parseRooms(String body) {
    return (jsonDecode(body) as List<dynamic>)
        .map((e) => Room.fromJson(e))
        .toList();
  }

  @override
  void dispose() {
    _roomsStreamController.close();
  }

  @override
  Future<ServerResponse> postRoom(Room room) async {
    final response = await http.post(Config.apiAddress + "/ApiRoom",
        body: jsonEncode(room.toJson()),
        headers: {"Content-Type": "application/json"});
    return ServerResponse(response.statusCode, response.body);
  }
}
