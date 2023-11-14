class PrayerTimeModel {
  final int? statusCode;
  final String? status;
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String day;
  final String year;
  final int month;

  PrayerTimeModel(
      {this.statusCode,
      this.status,
      required this.fajr,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      required this.day,
      required this.month,
      required this.year});

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json, int day) {
    return PrayerTimeModel(
        status: json["status"],
        statusCode: json["code"],
        fajr: json["data"][day]["timings"]["Fajr"],
        dhuhr: json["data"][day]["timings"]["Dhuhr"],
        asr: json["data"][day]["timings"]["Asr"],
        maghrib: json["data"][day]["timings"]["Maghrib"],
        isha: json["data"][day]["timings"]["Isha"],
        day: json["data"][day]["date"]["gregorian"]["day"],
        month: json["data"][day]["date"]["gregorian"]["month"]["number"],
        year: json["data"][day]["date"]["gregorian"]["year"]);
  }
}
