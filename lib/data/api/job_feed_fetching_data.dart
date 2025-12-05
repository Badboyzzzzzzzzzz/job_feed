import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class FetchingData {
  static const String baseUrl = "https://sme.sosme.api.elitevigour.com";


  static Future<http.Response> getJobPostList(
    String provideUrl,
    Map<String, String> param,
    Map<String, String> header,
  ) async {
    var url = Uri.https(baseUrl.replaceAll('https://', ''), provideUrl, param);
    try {
      final response = await http
          .get(url, headers: header)
          .timeout(const Duration(seconds: 10));
      return response;
    } on SocketException {
      throw Exception('Network connection failed');
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }
}
