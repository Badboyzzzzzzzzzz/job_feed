import 'package:job_feed/model/jp_response_list.dart';

abstract class JobFeedRepository {
  Future<JobPostListResponse> fetchJobPosts({
    String? languageCode,
    String? search,
    int? jbCompanyId,
    int? jbStatusRefId,
    int? jbTypeWorkRefId,
    int? jbExperienceLevelRefId,
    int? jbIndustryRefId,
    int? jbQualifyRefId,
    int? provinceRefId,
    double? salaryMin,
    double? salaryMax,
  });
}
