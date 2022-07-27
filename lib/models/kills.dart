import 'dart:convert';

class Kills {
  Map<String, int>? kills;

  Kills({
    required this.kills,
  });

  Map<String, dynamic> toMap() {
    return {
      'kills': kills,
    };
  }

  factory Kills.fromMap(Map<String, dynamic> map) {
    return Kills(
      kills: Map<String, int>.from(map['kills']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Kills.fromJson(String source) => Kills.fromMap(json.decode(source));

  Kills copyWith({
    Map<String, int>? kills,
  }) {
    return Kills(
      kills: kills ?? this.kills,
    );
  }
}
