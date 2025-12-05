import 'package:job_feed/model/jp_company.dart';

class JbCompanyHub {
  final int id;
  final Company? jbCompany;
  final int? jbPost;

  JbCompanyHub({required this.id, this.jbCompany, this.jbPost});

  factory JbCompanyHub.fromJson(Map<String, dynamic> json) {
    return JbCompanyHub(
      id: json['id'] as int,
      jbCompany: json['jb_company'] != null
          ? Company.fromJson(json['jb_company'] as Map<String, dynamic>)
          : null,
      jbPost: json['jb_post'] as int?,
    );
  }
}