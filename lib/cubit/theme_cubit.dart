import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:serag_app/view/style/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppThemes.lightTheme) {
    print('تم تهيئة الثيم الأولي: فاتح');
  }

  void toggleTheme() {
    emit(state == AppThemes.lightTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);
  }

  Future<void> updateThemeBasedOnTime({bool simulateTest = false}) async {
    try {
      final now = simulateTest
          ? DateTime.now().copyWith(
              hour: 5,
              minute:
                  0) // ضبط وقت اختباري (5:00 صباحًا) // وقت مزيف (ليكون وقت فجر)
          : DateTime.now();

      // 1. أولاً: جلب الموقع والبيانات
      Location location = Location();
      LocationData locationData = await location.getLocation();
      final lat = locationData.latitude;
      final long = locationData.longitude;

      // final now = DateTime.now(); // 2. تعريف now هنا
      final timestamp = now.millisecondsSinceEpoch ~/ 1000;

      final dio = Dio();
      final response = await dio.get(
        'https://api.aladhan.com/v1/timings/$timestamp',
        queryParameters: {
          'latitude': lat,
          'longitude': long,
          'method': 2,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final fajrString = data['data']['timings']['Fajr'] as String;
        print('وقت الفجر المستلم من API: $fajrString'); // أضف هذا السطر

        final parts = fajrString.split(":");
        final fajrHour = int.parse(parts[0]);
        final fajrMinute = int.parse(parts[1]);

        print('وقت الفجر المحلل: $fajrHour:$fajrMinute'); // أضف هذا السطر

        final fajrTime =
            DateTime(now.year, now.month, now.day, fajrHour, fajrMinute);
        final fajrEnd = fajrTime.add(const Duration(hours: 1, minutes: 30));

        print('نطاق الفجر: من $fajrTime إلى $fajrEnd'); // أضف هذا السطر
        print('الوقت الحالي: $now'); // أضف هذا السطر

        if (now.isAfter(fajrTime) && now.isBefore(fajrEnd)) {
          if (state != AppThemes.darkTheme) {
            emit(AppThemes.darkTheme);
            print('✅ تم تفعيل الثيم المظلم (وقت الفجر)');
          }
        } else {
          if (state != AppThemes.lightTheme) {
            emit(AppThemes.lightTheme);
            print('☀️ تم تفعيل الثيم الفاتح (خارج وقت الفجر)');
          }
        }
      }
    } catch (e) {
      print('⚠️ خطأ في تحديث الثيم: $e');
    }
  }
}
