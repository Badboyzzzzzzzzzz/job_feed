class Commune {
  final int id;
  final String name;
  final String languageCode;
  final String? code;

  Commune({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
  });

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['commune_ref']?['code'] as String?,
    );
  }
}