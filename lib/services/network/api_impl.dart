import 'package:dio/dio.dart';
import 'package:servio/app/locator.dart';
import 'package:servio/caches/preferences.dart';
import 'package:servio/constants/value_constants.dart';
import 'package:servio/models/authentication_response.dart';
import 'package:servio/models/data_source.dart';
import 'package:servio/models/digest.dart';
import 'package:servio/models/digest_request.dart';
import 'package:servio/models/report.dart';
import 'package:servio/services/network/api.dart';
import 'package:servio/utils/date.dart';

class ImplApi extends Api {
  Dio _dio = Dio();
  Preferences prefs = locator<Preferences>();

  ImplApi(apiUrl, token) {
    _dio.options.baseUrl = apiUrl;
    updateHeaders(token);
  }

  Future<Response> _postRequest(String endPoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;

    try {
      response = await _dio.post(endPoint, data: data, queryParameters: queryParameters);
      if (response.statusCode != 200)
        throw Exception("error ${response.statusCode} \n data:${response.data["error_description"]}");
    } on DioError catch (e) {
      print(e.message);
      throw Exception("error message ${e.message}; \n data:${e.response?.data["error_description"]}");
    }

    return response;
  }

  updateBaseUrl(String apiUrl) {
    _dio.options.baseUrl = apiUrl;
  }

  updateHeaders(String token) {
    _dio.options.headers = {
      "Authorization": "bearer $token",
      "Content-Type": "application/x-www-form-urlencoded",
    };
  }

  @override
  authentification(String email, String password) async {
    final response = await _postRequest(
      '/token',
      data: {
        "grant_type": "password",
        "username": email,
        "password": password,
      },
    );
    return (AuthenticationResponse.fromJson(response.data));
  }

  @override
  getReports() async {
    final response = await _postRequest(
      "/Report/Structure",
    );
    if (response.data is List) {
      return (response.data as List).map((e) => Report.fromJson(e)).toList();
    }
    return ([]);
  }

  @override
  getDataSources() async {
    final response = await _postRequest(
      "/Common/DataSources",
    );
    final data = response.data;
    if (data is List) {
      return data.map((e) => DataSource.fromJson(e)).toList();
    }
    return ([]);
  }

  getDigest(DigestRequest requestData) async {
    final response = await _postRequest(
      "/Digest/Get",
      data: requestData.toJson(),
    );
    return response.data;
  }

  @override
  getHotelDigest(DateTime from, DateTime to, List<DataSource> sources) async {
    final data = await getDigest(DigestRequest(
      from: formatForApiRequest(from),
      to: formatForApiRequest(to),
      sources: sources.where((s) => s.type == kHotelType).toList(),
    ));
    if (data is List) {
      return data.map((e) => HotelDigest.fromJson(e)).toList();
    }
    return ([]);
  }

  @override
  getRestaurantDigest(DateTime from, DateTime to, List<DataSource> sources) async {
    final data = await getDigest(DigestRequest(
      from: formatForApiRequest(from),
      to: formatForApiRequest(to),
      sources: sources.where((s) => s.type == kRestaurantType).toList(),
    ));
    if (data is List) {
      return data.map((e) => RestaurantDigest.fromJson(e)).toList();
    }
    return ([]);
  }
}
