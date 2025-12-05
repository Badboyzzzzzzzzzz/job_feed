import 'package:job_feed/model/jb_post_address.dart';
import 'package:job_feed/model/jb_post_company_hub.dart';
import 'package:job_feed/model/jb_post_file.dart';
import 'package:job_feed/model/jp_company.dart';
import 'package:job_feed/model/jp_experience_level.dart';
import 'package:job_feed/model/jp_industry.dart';
import 'package:job_feed/model/jp_qualify.dart';
import 'package:job_feed/model/jp_status.dart';
import 'package:job_feed/model/jp_type.dart';

class JobPost {
  final int id;
  final String? title;
  final String? description;
  final int? numPosition;
  final String? skills;
  final String? experience;
  final String? salaryMin;
  final String? salaryMax;
  final String? startDate;
  final String? endDate;
  final String? contactPerson;
  final String? otherBenefit;
  final String? recruitmentProcess;
  final String? createdAt;
  final int applyRecordCount;

  // Nested objects
  final CreatedBy? createdBy;
  final JbTypeWork? jbTypeWork;
  final JbExperienceLevel? jbExperienceLevel;
  final JbStatus? jbStatus;
  final JbIndustry? jbIndustry;
  final JbQualify? jbQualify;
  final Address? address;
  final List<JbFile> jbFiles;
  final List<JbCompanyHub> jbCompanyHub;

  // Convenience getters for backward compatibility
  String get workType => jbTypeWork?.name ?? '';
  String get experienceLevel => jbExperienceLevel?.name ?? '';
  String get industry => jbIndustry?.name ?? '';
  String get qualification => jbQualify?.name ?? '';
  String get province => address?.province?.name ?? '';
  Company? get company =>
      jbCompanyHub.isNotEmpty ? jbCompanyHub.first.jbCompany : null;

  String get postingDate {
    if (startDate == null || startDate!.isEmpty) return '';

    try {
      final postedDate = DateTime.parse(startDate!);
      final now = DateTime.now();
      final difference = now.difference(postedDate);

      String timeAgo;
      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes == 0) {
            timeAgo = 'ទើបតែឥឡូវ';
            return timeAgo;
          }
          timeAgo = '${difference.inMinutes} នាទីមុន';
        } else {
          timeAgo = '${difference.inHours} ម៉ោងមុន';
        }
      } else if (difference.inDays < 7) {
        timeAgo = '${difference.inDays} ថ្ងៃមុន';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        timeAgo = '$weeks សប្តាហ៍មុន';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        timeAgo = '$months ខែមុន';
      } else {
        final years = (difference.inDays / 365).floor();
        timeAgo = '$years ឆ្នាំមុន';
      }

      return 'បានចុះផ្សាយកាលពី $timeAgo។';
    } catch (e) {
      return startDate ?? '';
    }
  }

  JobPost({
    required this.id,
    this.title,
    this.description,
    this.numPosition,
    this.skills,
    this.experience,
    this.salaryMin,
    this.salaryMax,
    this.startDate,
    this.endDate,
    this.contactPerson,
    this.otherBenefit,
    this.recruitmentProcess,
    this.createdAt,
    this.applyRecordCount = 0,
    this.createdBy,
    this.jbTypeWork,
    this.jbExperienceLevel,
    this.jbStatus,
    this.jbIndustry,
    this.jbQualify,
    this.address,
    this.jbFiles = const [],
    this.jbCompanyHub = const [],
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      numPosition: json['num_position'] as int?,
      skills: json['skills'] as String?,
      experience: json['experience'] as String?,
      salaryMin: json['salary_min'] as String?,
      salaryMax: json['salary_max'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      contactPerson: json['contact_person'] as String?,
      otherBenefit: json['other_benefit'] as String?,
      recruitmentProcess: json['recruitment_process'] as String?,
      createdAt: json['created_at'] as String?,
      applyRecordCount: json['apply_record_count'] as int? ?? 0,
      createdBy: json['created_by'] != null
          ? CreatedBy.fromJson(json['created_by'] as Map<String, dynamic>)
          : null,
      jbTypeWork: json['jb_type_work'] != null
          ? JbTypeWork.fromJson(json['jb_type_work'] as Map<String, dynamic>)
          : null,
      jbExperienceLevel: json['jb_experience_level'] != null
          ? JbExperienceLevel.fromJson(
              json['jb_experience_level'] as Map<String, dynamic>,
            )
          : null,
      jbStatus: json['jb_status'] != null
          ? JbStatus.fromJson(json['jb_status'] as Map<String, dynamic>)
          : null,
      jbIndustry: json['jb_industry'] != null
          ? JbIndustry.fromJson(json['jb_industry'] as Map<String, dynamic>)
          : null,
      jbQualify: json['jb_qualify'] != null
          ? JbQualify.fromJson(json['jb_qualify'] as Map<String, dynamic>)
          : null,
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      jbFiles:
          (json['jb_files'] as List<dynamic>?)
              ?.map((e) => JbFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      jbCompanyHub:
          (json['jb_company_hub'] as List<dynamic>?)
              ?.map((e) => JbCompanyHub.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Get formatted salary range
  String get salaryRange {
    if (salaryMin == null && salaryMax == null) return 'Negotiable';
    if (salaryMin != null && salaryMax != null) {
      return '\$$salaryMin - \$$salaryMax';
    }
    if (salaryMin != null) return 'From \$$salaryMin';
    return 'Up to \$$salaryMax';
  }

  /// Get first image URL from jbFiles
  String? get imageUrl => jbFiles.isNotEmpty ? jbFiles.first.file : null;
}
