// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:job_feed/data/api/job_feed_api_endpoint.dart';
import 'package:job_feed/data/api/job_feed_fetching_data.dart';
import 'package:job_feed/data/repository/abstract/job_feed_repository.dart';
import 'package:job_feed/model/jp_response_list.dart';

class JobFeedNetworkApiRepository implements JobFeedRepository {
  @override
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
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, String> queryParams = {};
    if (languageCode != null) queryParams['language_code'] = languageCode;
    if (search != null) queryParams['search'] = search;
    if (jbCompanyId != null) {
      queryParams['jb_company_id'] = jbCompanyId.toString();
    }
    if (jbStatusRefId != null) {
      queryParams['jb_status_ref_id'] = jbStatusRefId.toString();
    }
    if (jbTypeWorkRefId != null) {
      queryParams['jb_type_work_ref_id'] = jbTypeWorkRefId.toString();
    }
    if (jbExperienceLevelRefId != null) {
      queryParams['jb_experience_level_ref_id'] = jbExperienceLevelRefId
          .toString();
    }
    if (jbIndustryRefId != null) {
      queryParams['jb_industry_ref_id'] = jbIndustryRefId.toString();
    }
    if (jbQualifyRefId != null) {
      queryParams['jb_qualify_ref_id'] = jbQualifyRefId.toString();
    }
    if (provinceRefId != null) {
      queryParams['province_ref_id'] = provinceRefId.toString();
    }
    if (salaryMin != null) queryParams['salary_min'] = salaryMin.toString();
    if (salaryMax != null) queryParams['salary_max'] = salaryMax.toString();

    try {
      final jobFeedResponse = await FetchingData.getJobPostList(
        JobFeedApiEndpoint.jobPosts,
        queryParams,
        headers,
      );
      print(
        'Jobbbbbbbbbbbbbbbbbbb feeeeeeeeeeeeeeeeeeeeeeeed : ${jobFeedResponse.body}',
      );
      if (jobFeedResponse.statusCode == 200) {
        final jsonData =
            json.decode(jobFeedResponse.body) as Map<String, dynamic>;
        return JobPostListResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load job posts: ${jobFeedResponse.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching job posts: $e');
    }
  }
}
