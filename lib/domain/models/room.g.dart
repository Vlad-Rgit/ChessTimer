// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
    json['id'] as int,
    json['name'] as String,
    json['player1'] as String,
    json['player2'] as String,
    json['timePlayer1'] as int,
    json['timePlayer2'] as int,
    json['addTime'] as int,
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'player1': instance.player1,
      'player2': instance.player2,
      'timePlayer1': instance.timePlayer1,
      'timePlayer2': instance.timePlayer2,
      'addTime': instance.addTime,
    };
