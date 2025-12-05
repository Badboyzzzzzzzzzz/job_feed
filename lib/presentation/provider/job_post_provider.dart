import 'package:flutter/material.dart';
import 'package:job_feed/data/repository/abstract/job_feed_repository.dart';
import 'package:job_feed/model/jp_response_list.dart';
import 'package:job_feed/presentation/provider/asyncvalue.dart';

class JobPostProvider extends ChangeNotifier {
  final JobFeedRepository repository;
  JobPostProvider({required this.repository});
  AsyncValue<JobPostListResponse> _jobPostListResponse = AsyncValue.empty();
  /// Getter
  AsyncValue<JobPostListResponse> get jobPostListResponse =>
      _jobPostListResponse;
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
  }) async {
    _jobPostListResponse = AsyncValue.loading();
    notifyListeners();
    try {    
      final response = await repository.fetchJobPosts(
        languageCode: languageCode,
        search: search,
        jbCompanyId: jbCompanyId,
        jbStatusRefId: jbStatusRefId,
        jbTypeWorkRefId: jbTypeWorkRefId,
        jbExperienceLevelRefId: jbExperienceLevelRefId,
        jbIndustryRefId: jbIndustryRefId,
        jbQualifyRefId: jbQualifyRefId,
        provinceRefId: provinceRefId,
        salaryMin: salaryMin,
        salaryMax: salaryMax,
      );
      _jobPostListResponse = AsyncValue.success(response);
      notifyListeners();
      return response;
    } catch (e) {
      _jobPostListResponse = AsyncValue.error(e.toString());
      notifyListeners();
      rethrow;
    }
  }
}
