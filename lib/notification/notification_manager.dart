import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showReminderNotification(int khatmaCount) async {
    const androidDetails = AndroidNotificationDetails(
      'khatma_reminder',
      'تنبيهات الختمة',
      channelDescription: 'تذكير بالختمات غير المكتملة',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      '📖 تذكير بالختمة',
      'لديك $khatmaCount ختمة غير مكتملة. شارك وأكمل الأجزاء المتبقية!',
      notificationDetails,
    );
  }
}
