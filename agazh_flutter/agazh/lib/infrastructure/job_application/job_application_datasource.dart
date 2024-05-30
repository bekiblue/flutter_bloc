import 'dart:convert';

import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/domain/job_application/job_application_model.dart';
import 'package:agazh/infrastructure/auth/auth_datasource.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobApplicationDataSource {

  JobApplicationDataSource._();

  static final JobApplicationDataSource _singleton = JobApplicationDataSource._();

  factory JobApplicationDataSource() {
    return _singleton;
  }

  Future<void> createJobApplication(JobApplication jobApplication) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('POST', Uri.parse('$baseUrl/application/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(jobApplication.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 201) {
      throw Exception('Failed to create application');
    }
  }

  Future<List<JobApplication>> getMyApplications(Role forRole) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('GET', Uri.parse('$baseUrl/application/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({'me':(await AuthDataSource().getMe(token!)).id, 'role': forRole == Role.client ? 'client' : 'freelancer'});

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var data = jsonDecode(body);
      return (data as List).map((e) => JobApplication.fromJson(e)).toList();
    } else {
      throw Exception('Failed to get applications');
    }
  }

  updateApplication(JobApplication application) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('PUT', Uri.parse('$baseUrl/application/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(application.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('Failed to update application');
    }
  }

  deleteApplication(JobApplication application) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var request = Request('DELETE', Uri.parse('$baseUrl/application/'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode(application.toJson());

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode != 204) {
      throw Exception('Failed to delete application');
    }
  }


}