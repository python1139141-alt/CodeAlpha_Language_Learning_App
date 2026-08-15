import 'dart:convert';

class UserProfile {
  final String name;
  final String nativeLanguage;
  final String targetLanguage;
  final String expertiseLevel;
  final int streakDays;
  final int xpPoints;

  const UserProfile({
    required this.name,
    required this.nativeLanguage,
    required this.targetLanguage,
    required this.expertiseLevel,
    this.streakDays = 1,
    this.xpPoints = 0,
  });

  UserProfile copyWith({
    String? name,
    String? nativeLanguage,
    String? targetLanguage,
    String? expertiseLevel,
    int? streakDays,
    int? xpPoints,
  }) {
    return UserProfile(
      name: name ?? this.name,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      expertiseLevel: expertiseLevel ?? this.expertiseLevel,
      streakDays: streakDays ?? this.streakDays,
      xpPoints: xpPoints ?? this.xpPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nativeLanguage': nativeLanguage,
      'targetLanguage': targetLanguage,
      'expertiseLevel': expertiseLevel,
      'streakDays': streakDays,
      'xpPoints': xpPoints,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] as String? ?? '',
      nativeLanguage: map['nativeLanguage'] as String? ?? '',
      targetLanguage: map['targetLanguage'] as String? ?? '',
      expertiseLevel: map['expertiseLevel'] as String? ?? 'Beginner',
      streakDays: map['streakDays'] as int? ?? 1,
      xpPoints: map['xpPoints'] as int? ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserProfile.fromJson(String source) {
    return UserProfile.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}
