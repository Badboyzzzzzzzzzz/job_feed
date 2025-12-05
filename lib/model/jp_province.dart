class Province {
  final int id;
  final String name;
  final String languageCode;
  final String? code;
  final int? refId;

  Province({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
    this.refId,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['province_ref']?['code'] as String?,
      refId: json['province_ref']?['id'] as int?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Province && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
