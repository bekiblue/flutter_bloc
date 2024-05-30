import 'dart:convert';

import 'package:agazh/domain/job/job_model.dart';
import 'package:agazh/infrastructure/auth/auth_datasource.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDataSource {
  JobDataSource._();

  static final JobDataSource _singleton = JobDataSource._();

  factory JobDataSource() {
    return _singleton;
  }

  Future<List<Job>> getJobs(int? authorId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('GET', Uri.parse('$baseUrl/job/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    if (authorId != null) {
      request.body = jsonEncode({'authorId': authorId});
    }

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var data = jsonDecode(body);
      return (data as List).map((e) => Job.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get user');
    }
  }

  createJob(Job job) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('POST', Uri.parse('$baseUrl/job/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(job.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 201) {
      throw Exception('Failed to create job');
    }
  }

  updateJob(Job job) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('PUT', Uri.parse('$baseUrl/job/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(job.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('Failed to update job');
    }
  }

  deleteJob(Job job) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('DELETE', Uri.parse('$baseUrl/job/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(job.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 204) {
      throw Exception('Failed to delete job');
    }
  }
}
