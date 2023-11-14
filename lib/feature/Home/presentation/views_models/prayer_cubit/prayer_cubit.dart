import 'package:bloc/bloc.dart';
import 'package:prayer_app/core/errors/failure.dart';
import 'package:prayer_app/feature/Home/data/models/paryer_time_model.dart';
import 'package:prayer_app/feature/Home/data/repo/home_repo.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit(this.homeRepo) : super(PrayerInitial());

  HomeRepo homeRepo;

  Future<void> fetchPrayerTime(
      {required String city,
      required String country,
      required int year,
      required int month,
      required int day}) async {
    emit(PrayerLoading());

    var response = await homeRepo.fetchPrayersTime(
        city: city, country: country, year: year, month: month, day: day);

    response.fold((failure) {
      emit(PrayerError(failure));
    }, (prayersTime) {
      emit(PrayerSuccess(prayersTime));
    });
  }
}
