import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'supabase_service.dart';

class NotificationService {
  static const String _khatmaTask = "daily_khatma_reminder";

  static Future<void> scheduleAllKhatmas() async {
    final khatmas = await SupabaseService.supabase
        .from('khatmat_khasa')
        .select('id, created_at, reserved_parts');

    for (final khatma in khatmas) {
      final parts = (khatma['reserved_parts'] as List).length;
      if (parts < 30) {
        await scheduleDailyReminder(
          khatmaId: khatma['id'] as int,
          creationTime: DateTime.parse(khatma['created_at'] as String),
        );
      }
    }
  }

  static Future<void> scheduleDailyReminder({
    required int khatmaId,
    required DateTime creationTime,
  }) async {
    final now = DateTime.now();
    final nextTime = _calculateNextTime(creationTime, now);

    await Workmanager().registerPeriodicTask(
      'khatma_$khatmaId',
      _khatmaTask,
      // frequency: const Duration(seconds: 30),
      // initialDelay: const Duration(seconds: 5),
      frequency: const Duration(hours: 24),
      initialDelay: nextTime.difference(now),
      inputData: {'khatmaId': khatmaId},
    );
    debugPrint('تم جدولة إشعار اختباري للختمة $khatmaId');
  }

  static DateTime _calculateNextTime(DateTime creationTime, DateTime now) {
    var nextTime = DateTime(
      now.year,
      now.month,
      now.day,
      creationTime.hour,
      creationTime.minute,
    );
    if (nextTime.isBefore(now)) {
      nextTime = nextTime.add(const Duration(days: 1));
    }
    return nextTime;
  }

  static Future<void> cancelReminder(int khatmaId) async {
    await Workmanager().cancelByTag('khatma_$khatmaId');
  }
}
