import 'package:dio/dio.dart';
import 'package:servio/models/authentication_response.dart';
import 'package:servio/models/report.dart';

abstract class Api {
  Future<AuthenticationResponse> authentification(String email, String password);
  Future<List<Report>> getReports();
  // Future<Response> getDataSources();
  // Future<Response> getDigest();
}
