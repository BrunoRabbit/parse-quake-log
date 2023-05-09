class KillsByMeans {
  Map<String, dynamic> killsByMeans;

  KillsByMeans({
    required this.killsByMeans,
  });

  factory KillsByMeans.fromMap(Map<String, dynamic> map) {
    return KillsByMeans(
      killsByMeans: Map<String, dynamic>.from(map['killsByMeans']),
    );
  }
}
