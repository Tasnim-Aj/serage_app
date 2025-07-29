import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

class NotificationService {
  static const String _khatmaTask = "khatma_reminder";

  /// جدولة جميع الختمات غير المكتملة
  static Future<void> scheduleAllKhatmas() async {
    try {
      await Workmanager().cancelAll();

      final response = await Supabase.instance.client
          .from('khatmat_khasa')
          .select('id, created_at, name, reserved_parts')
          .lt('reserved_parts.length', 30);

      debugPrint('### جاري جدولة ${response.length} ختمة');

      for (final khatma in response) {
        await scheduleKhatmaNotification(
          khatmaId: khatma['id'] as int,
          creationTime: DateTime.parse(khatma['created_at'] as String),
          khatmaName: khatma['name'] as String,
        );
      }
    } catch (e) {
      debugPrint('### خطأ في جدولة الختمات: $e');
    }
  }

  /// جدولة إشعار لختمة واحدة
  static Future<void> scheduleForKhatma({
    required int khatmaId,
    required DateTime creationTime,
    required String khatmaName,
  }) async {
    await scheduleKhatmaNotification(
      khatmaId: khatmaId,
      creationTime: creationTime,
      khatmaName: khatmaName,
    );
  }

  /// الدالة الأساسية للجدولة
  static Future<void> scheduleKhatmaNotification({
    required int khatmaId,
    required DateTime creationTime,
    required String khatmaName,
  }) async {
    final now = DateTime.now();
    final nextTime = _calculateNextTime(creationTime, now);

    await Workmanager().registerOneOffTask(
      'khatma_${khatmaId}_${now.millisecondsSinceEpoch}',
      _khatmaTask,
      initialDelay: nextTime.difference(now),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      inputData: {
        'khatmaId': khatmaId,
        'khatmaName': khatmaName,
        'creationTime': creationTime.toIso8601String(),
      },
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: Duration(minutes: 10),
    );

    debugPrint('''
### تم جدولة ختمة:
- ID: $khatmaId
- الاسم: $khatmaName
- الموعد القادم: ${nextTime.toString()}
''');
  }

  /// إلغاء الإشعارات لختمة محددة
  static Future<void> cancelReminder(int khatmaId) async {
    try {
      await Workmanager().cancelByTag('khatma_${khatmaId}_*');
      debugPrint('### تم إلغاء إشعارات الختمة $khatmaId');
    } catch (e) {
      debugPrint('### خطأ في إلغاء الإشعارات: $e');
    }
  }

  /// حساب وقت التنفيذ التالي
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
}
