class JbExperienceLevel {
  final int id;
  final String name;
  final String languageCode;
  final String? code;
  final int? refId;

  JbExperienceLevel({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
    this.refId,
  });

  factory JbExperienceLevel.fromJson(Map<String, dynamic> json) {
    return JbExperienceLevel(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['jb_experience_level_ref']?['code'] as String?,
      refId: json['jb_experience_level_ref']?['id'] as int?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JbExperienceLevel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
