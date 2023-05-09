import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Deaths {
  Map<String, int> deathMap;

  Deaths(
    this.deathMap,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deathMap': deathMap,
    };
  }

  factory Deaths.fromMap(Map<String, dynamic> map) {
    return Deaths(
      Map<String, int>.from(
        (map['deathMap'] as Map<String, int>),
      ),
    );
  }
}
