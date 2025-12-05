class JbFile {
  final int id;
  final String file;
  final int? jbCompany;
  final int? jbPost;

  JbFile({required this.id, required this.file, this.jbCompany, this.jbPost});

  factory JbFile.fromJson(Map<String, dynamic> json) {
    return JbFile(
      id: json['id'] as int,
      file: json['file'] as String,
      jbCompany: json['jb_company'] as int?,
      jbPost: json['jb_post'] as int?,
    );
  }
}