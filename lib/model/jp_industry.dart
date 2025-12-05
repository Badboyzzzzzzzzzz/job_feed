class JbIndustry {
  final int id;
  final String name;
  final String languageCode;
  final String? code;

  JbIndustry({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
  });

  factory JbIndustry.fromJson(Map<String, dynamic> json) {
    return JbIndustry(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['jb_industry_ref']?['code'] as String?,
    );
  }
}