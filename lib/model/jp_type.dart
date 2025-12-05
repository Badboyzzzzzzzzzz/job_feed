class JbTypeWork {
  final int id;
  final String name;
  final String languageCode;
  final String? code;
  final int? refId;

  JbTypeWork({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
    this.refId,
  });

  factory JbTypeWork.fromJson(Map<String, dynamic> json) {
    return JbTypeWork(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['jb_type_work_ref']?['code'] as String?,
      refId: json['jb_type_work_ref']?['id'] as int?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JbTypeWork && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
