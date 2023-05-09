class Kills {
  Map<String, int>? kills;

  Kills({
    required this.kills,
  });

  factory Kills.fromMap(Map<String, dynamic> map) {
    return Kills(
      kills: Map<String, int>.from(map['kills']),
    );
  }
}
