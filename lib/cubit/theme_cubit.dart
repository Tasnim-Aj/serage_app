import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:serag_app/view/style/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppThemes.lightTheme);

  void toggleTheme() {
    emit(state == AppThemes.lightTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);
  }

  // Future<void> updateThemeBasedOnTime() async {
  //   try {
  //     final position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     final lat = position.latitude;
  //     final long = position.longitude;
  //
  //     final now = DateTime.now();
  //     final timestamp = now.millisecondsSinceEpoch ~/ 1000;
  //
  //     final dio = Dio();
  //     final response = await dio.get(
  //       'https://api.aladhan.com/v1/timings/$timestamp',
  //       queryParameters: {
  //         'latitude': lat,
  //         'longitude': long,
  //         'method': 2,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       final fajrString = data['data']['timings']['Fajr'] as String;
  //
  //       final parts = fajrString.split(":");
  //       final fajrHour = int.parse(parts[0]);
  //       final fajrMinute = int.parse(parts[1]);
  //
  //       final fajrTime =
  //           DateTime(now.year, now.month, now.day, fajrHour, fajrMinute);
  //       final fajrEnd = fajrTime.add(const Duration(hours: 1, minutes: 30));
  //
  //       if (now.isAfter(fajrTime) && now.isBefore(fajrEnd)) {
  //         emit(AppThemes.lightTheme);
  //       } else {
  //         emit(AppThemes.darkTheme);
  //       }
  //     } else {
  //       print('فشل في جلب وقت الفجر من API');
  //     }
  //   } catch (e) {
  //     print('خطأ في Dio أو تحديد الموقع: $e');
  //   }
  // }
}
