// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:parse_quake_log/models/deaths.dart';
import 'package:parse_quake_log/models/kills.dart';
import 'package:parse_quake_log/models/kills_by_means.dart';
import 'package:parse_quake_log/models/player.dart';

class Round {
  int? totalKills;
  List<Player>? players;
  Kills? kills;
  KillsByMeans killsByMeans;
  Deaths deaths;

  Round(
    this.totalKills,
    this.players,
    this.kills,
    this.killsByMeans,
    this.deaths,
  );

  Map<String, dynamic> toMap() {
    return {
      'totalKills': totalKills,
      'players': players?.map((x) => x.toMap()).toList(),
      'kills': kills!.kills,
      'killsByMeans': killsByMeans.killsByMeans,
    };
  }

  factory Round.fromMap(Map<String, dynamic> map) {
    return Round(
      map['totalKills']?.toInt(),
      map['players'] != null
          ? List<Player>.from(map['players']?.map((x) => Player.fromMap(x)))
          : null,
      map['kills'] != null ? Kills.fromMap(map['kills']) : null,
      KillsByMeans.fromMap(map['killsByMeans']),
      Deaths.fromMap(map['deaths']),
    );
  }
}
