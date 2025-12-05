class Village {
  final int id;
  final String name;
  final String languageCode;
  final String? code;

  Village({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['village_ref']?['code'] as String?,
    );
  }
}