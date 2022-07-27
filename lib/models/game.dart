import 'dart:convert';

import 'package:test_cloudwalk/models/round.dart';

class Game {
  Set<Round> game;
  int count;

  Game(
    this.game,
    this.count,
  );

  Map<String, dynamic> toMap() {
    return {
      'game_$count': game.map((x) => x.toMap()).toList(),
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      Set<Round>.from(map['game']?.map((x) => Round.fromMap(x))),
      map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));
}
