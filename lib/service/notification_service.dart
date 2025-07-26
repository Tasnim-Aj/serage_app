import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('ic_launcher');

    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings);

    // tz.initializeTimeZones();
  }

  static Future<void> scheduleReminderAfter({
    required String khatmaName,
    required DateTime creationTime,
    Duration duration = const Duration(minutes: 1), // الوقت بعد الإنشاء للإشعار
  }) async {
    // نحول وقت الإنشاء إلى توقيت المنطقة المحلية ثم نضيف مدة الانتظار (دقيقة)
    final scheduledTime =
        tz.TZDateTime.from(creationTime, tz.local).add(duration);

    await _plugin.zonedSchedule(
      0,
      '📖 تذكير بالختمة',
      'مرت دقيقة على ختمة "$khatmaName"، هل قرأت وردك؟',
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'تذكير الختمة',
          channelDescription: 'إشعارات خاصة بالختمات بعد دقيقة من الإنشاء',
          // channelDescription: 'إشعارات خاصة بالختمات بعد 24 ساعة',
          importance: Importance.max,
          priority: Priority.high,
          icon: 'ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
