import 'dart:convert';

class Player {
  final String name;
  final int score;
  final int ping;

  Player(
    this.name,
    this.score,
    this.ping,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'ping': ping,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['name'] ?? '',
      map['score']?.toInt() ?? 0,
      map['ping']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));
}
