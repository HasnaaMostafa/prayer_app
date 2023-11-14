import 'package:flutter/material.dart';

class CustomPrayerWidget extends StatelessWidget {
  const CustomPrayerWidget({
    super.key,
    required this.prayerName,
    required this.time,
  });

  final String prayerName;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                prayerName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff4ee4df),
          height: 30,
        ),
      ],
    );
  }
}
