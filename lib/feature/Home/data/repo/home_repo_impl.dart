import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prayer_app/core/errors/failure.dart';
import 'package:prayer_app/core/services/api_service.dart';
import 'package:prayer_app/feature/Home/data/models/paryer_time_model.dart';
import 'package:prayer_app/feature/Home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiService apiService;
  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failure, PrayerTimeModel>> fetchPrayersTime(
      {required String city,
      required String country,
      required int year,
      required int month,
      required int day}) async {
    try {
      final result = await apiService.get(
          city: city, country: country, year: year, month: month);

      PrayerTimeModel prayerTimeModel = PrayerTimeModel.fromJson(result, day);

      return right(prayerTimeModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
