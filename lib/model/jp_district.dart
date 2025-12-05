class District {
  final int id;
  final String name;
  final String languageCode;
  final String? code;

  District({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['district_ref']?['code'] as String?,
    );
  }
}