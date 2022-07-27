import 'dart:convert';

class KillsByMeans {
  Map<String, dynamic> killsByMeans;
  KillsByMeans({
    required this.killsByMeans,
  });

  Map<String, dynamic> toMap() {
    return {
      'killsByMeans': killsByMeans,
    };
  }

  factory KillsByMeans.fromMap(Map<String, dynamic> map) {
    return KillsByMeans(
      killsByMeans: Map<String, dynamic>.from(map['killsByMeans']),
    );
  }

  String toJson() => json.encode(toMap());

  factory KillsByMeans.fromJson(String source) =>
      KillsByMeans.fromMap(json.decode(source));

  KillsByMeans copyWith({
    Map<String, dynamic>? killsByMeans,
  }) {
    return KillsByMeans(
      killsByMeans: killsByMeans ?? this.killsByMeans,
    );
  }
}
