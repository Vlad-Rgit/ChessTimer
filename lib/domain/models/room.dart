import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable(nullable: false)
class Room {
  final int id;
  final String name;
  final String player1;
  final String player2;
  final int timePlayer1;
  final int timePlayer2;
  final int addTime;

  const Room(this.id, this.name, this.player1, this.player2, this.timePlayer1,
      this.timePlayer2, this.addTime);

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Room &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          player1 == other.player1 &&
          player2 == other.player2 &&
          timePlayer1 == other.timePlayer1 &&
          timePlayer2 == other.timePlayer2 &&
          addTime == other.addTime;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      player1.hashCode ^
      player2.hashCode ^
      timePlayer1.hashCode ^
      timePlayer2.hashCode ^
      addTime.hashCode;
}
