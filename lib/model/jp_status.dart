class JbStatus {
  final int id;
  final String name;
  final String languageCode;
  final String? code;

  JbStatus({
    required this.id,
    required this.name,
    required this.languageCode,
    this.code,
  });

  factory JbStatus.fromJson(Map<String, dynamic> json) {
    return JbStatus(
      id: json['id'] as int,
      name: json['name'] as String,
      languageCode: json['language_code'] as String,
      code: json['jb_status_ref']?['code'] as String?,
    );
  }
}