import 'dart:convert';

import 'package:parse_quake_log/models/round.dart';

class Game {
  Round game;
  int count;

  Game(
    this.game,
    this.count,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'game_$count': game.toMap(),
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      Round.fromMap(map['game'] as Map<String, dynamic>),
      map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) =>
      Game.fromMap(json.decode(source) as Map<String, dynamic>);
}
