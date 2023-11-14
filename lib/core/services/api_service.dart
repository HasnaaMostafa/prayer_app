import 'package:dio/dio.dart';

class ApiService {
  Dio dio;
  ApiService(this.dio);

  Future<Map<String, dynamic>> get(
      {required String city,
      required String country,
      required int year,
      required int month}) async {
    String baseUrl =
        "https://api.aladhan.com/v1/calendarByCity/$year/$month?city=$city&country=$country&method=5";
    Response response = await dio.get(baseUrl);

    return response.data;
  }
}
