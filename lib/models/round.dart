import 'dart:convert';

import 'package:test_cloudwalk/models/death.dart';
import 'package:test_cloudwalk/models/kills.dart';
import 'package:test_cloudwalk/models/kills_by_means.dart';
import 'package:test_cloudwalk/models/player.dart';

class Round {
  int? totalKills;
  List<Player>? players;
  Kills? kills;
  List<Death>? deaths;
  KillsByMeans killsByMeans;

  Round(
    this.totalKills,
    this.players,
    this.kills,
    this.deaths,
    this.killsByMeans,
  );

  Map<String, dynamic> toMap() {
    return {
      'totalKills': totalKills,
      'players': players?.map((x) => x.toMap()).toList(),
      'kills': kills?.toMap(),
      'deaths': deaths?.map((x) => x.toMap()).toList(),
      'killsByMeans': killsByMeans.toMap(),
    };
  }

  factory Round.fromMap(Map<String, dynamic> map) {
    return Round(
      map['totalKills']?.toInt(),
      map['players'] != null
          ? List<Player>.from(map['players']?.map((x) => Player.fromMap(x)))
          : null,
      map['kills'] != null ? Kills.fromMap(map['kills']) : null,
      map['deaths'] != null
          ? List<Death>.from(map['deaths']?.map((x) => Death.fromMap(x)))
          : null,
      KillsByMeans.fromMap(map['killsByMeans']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Round.fromJson(String source) => Round.fromMap(json.decode(source));

  Round copyWith({
    int? totalKills,
    List<Player>? players,
    Kills? kills,
    List<Death>? deaths,
    KillsByMeans? killsByMeans,
  }) {
    return Round(
      totalKills ?? this.totalKills,
      players ?? this.players,
      kills ?? this.kills,
      deaths ?? this.deaths,
      killsByMeans ?? this.killsByMeans,
    );
  }
}
