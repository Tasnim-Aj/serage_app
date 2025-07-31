import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await notificationsPlugin.initialize(initSettings);

    // هذه أهم نقطة: لا تتجاهلها
    final androidDetails = AndroidNotificationDetails(
      'khatma_channel',
      'ختمات',
      channelDescription: 'قناة تذكير الختمات',
      importance: Importance.max,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      inputData?['khatmaId'] ?? 0,
      'تذكير ختمة',
      'حان وقت قراءة جزء من ختمة: ${inputData?['khatmaName'] ?? ''}',
      notificationDetails,
    );

    return Future.value(true);
  });
}
