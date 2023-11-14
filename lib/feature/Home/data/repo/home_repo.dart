import 'package:dartz/dartz.dart';
import 'package:prayer_app/feature/Home/data/models/paryer_time_model.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, PrayerTimeModel>> fetchPrayersTime(
      {required String city,
      required String country,
      required int year,
      required int month,
      required int day});
}
