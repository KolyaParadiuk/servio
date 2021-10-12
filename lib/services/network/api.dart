import 'package:servio/models/authentication_response.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:servio/models/mobile_settings.dart';
import 'package:servio/models/report.dart';

abstract class Api {
  Future<AuthenticationResponse> authentification(String email, String password);
  Future<List<Report>> getReports();
  Future<List<DataSource>> getDataSources();
  Future<List<HotelDigest>> getHotelDigest(DateTime from, DateTime to, List<DataSource> sources);
  Future<List<RestaurantDigest>> getRestaurantDigest(DateTime from, DateTime to, List<DataSource> sources);
  Future<MobildSettings> getMobileSettings();
}
