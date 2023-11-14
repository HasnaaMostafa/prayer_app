import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/core/services/location_service.dart';
import 'package:prayer_app/core/widgets/custom_error_widget.dart';
import 'package:prayer_app/core/widgets/custom_loading_indicator_widget.dart';
import 'package:prayer_app/feature/Home/data/models/paryer_time_model.dart';
import 'package:prayer_app/feature/Home/presentation/views/widgets/custom_calender.dart';
import 'package:prayer_app/feature/Home/presentation/views/widgets/custom_prayer_widget.dart';
import 'package:prayer_app/feature/Home/presentation/views_models/prayer_cubit/prayer_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  Placemark? placemark;
  PrayerTimeModel? prayerTimeModel;
  int? day;
  String? city;
  String? country;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    await GetLocation.requestLocationPermission();
    placemark = await GetLocation.getCurrentLocation();
    if (placemark != null) {
      city = placemark!.locality ?? " ";
      country = placemark!.country ?? " ";
      BlocProvider.of<PrayerCubit>(context).fetchPrayerTime(
          city: city!,
          country: country!,
          year: DateTime.now().year,
          month: DateTime.now().month,
          day: DateTime.now().day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: const Color(0xffdcf9f7),
            body: Column(
              children: [
                CustomCalender(
                  onDaySelected: (selectedDate) {
                    setState(() {
                      day = selectedDate.day;
                      BlocProvider.of<PrayerCubit>(context).fetchPrayerTime(
                          city: city!,
                          country: country!,
                          year: selectedDate.year,
                          month: selectedDate.month,
                          day: day! - 1);
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: BlocConsumer<PrayerCubit, PrayerState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is PrayerLoading) {
                            return const CustomLoadingIndicator();
                          } else if (state is PrayerSuccess) {
                            prayerTimeModel = state.prayerTimeModel;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                CustomPrayerWidget(
                                    prayerName: "Fajr",
                                    time: parseTime(
                                        year: int.parse(prayerTimeModel!.year),
                                        month:
                                            prayerTimeModel!.month.toString(),
                                        day: prayerTimeModel!.day,
                                        hour: int.parse(prayerTimeModel!.fajr
                                            .substring(0, 2)),
                                        min: int.parse(prayerTimeModel!.fajr
                                            .substring(3, 5)))),
                                CustomPrayerWidget(
                                  prayerName: "Duhr",
                                  time: parseTime(
                                      year: int.parse(prayerTimeModel!.year),
                                      month: prayerTimeModel!.month.toString(),
                                      day: prayerTimeModel!.day,
                                      hour: int.parse(prayerTimeModel!.dhuhr
                                          .substring(0, 2)),
                                      min: int.parse(prayerTimeModel!.dhuhr
                                          .substring(3, 5))),
                                ),
                                CustomPrayerWidget(
                                    prayerName: "Asr",
                                    time: parseTime(
                                        year: int.parse(prayerTimeModel!.year),
                                        month:
                                            prayerTimeModel!.month.toString(),
                                        day: prayerTimeModel!.day,
                                        hour: int.parse(prayerTimeModel!.asr
                                            .substring(0, 2)),
                                        min: int.parse(prayerTimeModel!.asr
                                            .substring(3, 5)))),
                                CustomPrayerWidget(
                                    prayerName: "Maghreb",
                                    time: parseTime(
                                        year: int.parse(prayerTimeModel!.year),
                                        month:
                                            prayerTimeModel!.month.toString(),
                                        day: prayerTimeModel!.day,
                                        hour: int.parse(prayerTimeModel!.maghrib
                                            .substring(0, 2)),
                                        min: int.parse(prayerTimeModel!.maghrib
                                            .substring(3, 5)))),
                                CustomPrayerWidget(
                                    prayerName: "Esha",
                                    time: parseTime(
                                        year: int.parse(prayerTimeModel!.year),
                                        month:
                                            prayerTimeModel!.month.toString(),
                                        day: prayerTimeModel!.day,
                                        hour: int.parse(prayerTimeModel!.isha
                                            .substring(0, 2)),
                                        min: int.parse(prayerTimeModel!.isha
                                            .substring(3, 5)))),
                              ],
                            );
                          } else if (state is PrayerError) {
                            return CustomErrorWidget(
                                errMessage: state.failure.toString());
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ));
      }),
    );
  }

  String parseTime({
    required int year,
    required String month,
    required String day,
    required int hour,
    required int min,
  }) {
    var formatTime = DateFormat.jm().format(DateTime(
      year,
      int.parse(month),
      int.parse(day),
      hour,
      min,
    ));
    return formatTime;
  }
}
