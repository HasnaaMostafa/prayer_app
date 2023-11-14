part of 'prayer_cubit.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerSuccess extends PrayerState {
  PrayerTimeModel prayerTimeModel;
  PrayerSuccess(this.prayerTimeModel);
}

class PrayerLoading extends PrayerState {}

class PrayerError extends PrayerState {
  Failure failure;
  PrayerError(this.failure);
}
