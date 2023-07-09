import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget currentWeather(String? city, String? temp, int? status) {
  return Container(
    margin: const EdgeInsets.only(left: 0, right: 0),
    child: Wrap(
      // alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${city != 'null' ? city : '...'},',
          style: const TextStyle(color: Colors.white60, fontFamily: 'Inter'),
        ),
        Text(
          ' ${temp != 'null' ? temp : '...'}℃  ',
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: Lottie.asset(
              'assets/images/weather/${getIconWeather(status)}.json'),
        )
      ],
    ),
  );
}

String getIconWeather(int? x) {
  TimeOfDay day = TimeOfDay.now();
  int hours = DateTime.now().hour;
  if (x == 1 || x == 2 || x == 30 || x == 33 || x == 34) {
    switch (checkDayNight(hours)) {
      case 1:
        return 'w1';
      case 0:
        return 'w13';
      default:
        return 'w0';
    }
  } else if (x == 3) {
    switch (day.period) {
      case DayPeriod.am:
        return 'w2';
      case DayPeriod.pm:
        return 'w11';
      default:
        return 'w0';
    }
  } else if (x == 4 || x == 5 || x == 35 || x == 36) {
    switch (checkDayNight(hours)) {
      case 1:
        return 'w3';
      case 0:
        return 'w11';
      default:
        return 'w0';
    }
  } else if (x == 14) {
    switch (checkDayNight(hours)) {
      case 1:
        return 'w4';
      case 0:
        return 'w12';
      default:
        return 'w0';
    }
  } else if (x == 6 || x == 7 || x == 8 || x == 38 || x == 43) {
    return 'w5';
  } else if (x == 13 || x == 12 || x == 18 || x == 39 || x == 43) {
    return 'w6';
  } else if (x == 15 || x == 16 || x == 17 || x == 41 || x == 42) {
    return 'w7';
  } else if (x == 11) {
    return 'w8';
  } else if (x == 14 || x == 20 || x == 21 || x == 22 || x == 44 || x == 29) {
    return 'w9';
  } else if (x == 24 || x == 25 || x == 26) {
    return 'w10';
  } else {
    //37
    return 'w11';
  }
}

int checkDayNight(int hours) {
  // if (hour < 12) {
  //   return 'Morning';
  // }
  if (hours < 17) {
    return 1;
  } else {
    return 0;
  }
}
