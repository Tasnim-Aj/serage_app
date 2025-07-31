import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String _channelId = 'khatma_channel';

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Damascus'));

    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            'إشعارات الختمة الخاصة',
            description: 'قناة لإشعارات متابعة الختمات',
            importance: Importance.high,
          ),
        );
  }

  static Future<void> scheduleKhatmaNotification({
    required int khatmaId,
    required DateTime creationTime,
    required String khatmaName,
  }) async {
    final scheduledDate =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 2));

    debugPrint('🔔 جدولة إشعار لختمة "$khatmaName" (ID: $khatmaId)');
    debugPrint('🕒 سيتم إرسال الإشعار في (محلي): $scheduledDate');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      khatmaId,
      '📖 متابعة ختمة خاصة: $khatmaName',
      'لقد حان موعد متابعة الختمة!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'إشعارات الختمة الخاصة',
          channelDescription: 'قناة لإشعارات متابعة الختمات',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  static Future<void> showTestNotification() async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'اختبار إشعار',
      '🚀 هذا إشعار تجريبي من NotificationService',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'إشعارات الختمة الخاصة',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> cancelReminder(int khatmaId) async {
    await _flutterLocalNotificationsPlugin.cancel(khatmaId);
  }
}
