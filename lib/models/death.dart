import 'dart:convert';

import 'package:test_cloudwalk/models/player.dart';

class Death {
  final Player player;
  final int quantity;

  Death(
    this.player,
    this.quantity,
  );

  Map<String, dynamic> toMap() {
    return {
      'player': player.toMap(),
      'quantity': quantity,
    };
  }

  factory Death.fromMap(Map<String, dynamic> map) {
    return Death(
      Player.fromMap(map['player']),
      map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Death.fromJson(String source) => Death.fromMap(json.decode(source));
}
