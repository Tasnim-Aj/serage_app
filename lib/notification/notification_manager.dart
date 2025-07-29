// lib/notification/notification_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../service/supabase_service.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'quran_channel',
      'تذكير القرآن',
      channelDescription: 'إشعارات تذكير قراءة القرآن',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true,
      visibility: NotificationVisibility.public,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<bool> checkKhatmaCompletion(int khatmaId) async {
    try {
      final response = await SupabaseService.supabase
          .from('khatmat_khasa')
          .select('reserved_parts')
          .eq('id', khatmaId)
          .single();

      final parts = (response['reserved_parts'] as List).length;
      return parts >= 30;
    } catch (e) {
      debugPrint('Error checking khatma: $e');
      return false;
    }
  }
}
