import 'package:job_feed/model/jp_model.dart';

class JobPostListResponse {
  final String? next;
  final String? previous;
  final int count;
  final List<JobPost> results;

  JobPostListResponse({
    this.next,
    this.previous,
    required this.count,
    required this.results,
  });

  factory JobPostListResponse.fromJson(Map<String, dynamic> json) {
    return JobPostListResponse(
      next: json['data']['next'] as String?,
      previous: json['data']['previous'] as String?,
      count: json['data']['count'] as int,
      results: (json['data']['results'] as List)
          .map((i) => JobPost.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}