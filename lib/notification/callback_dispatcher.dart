import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

import '../service/notification_service.dart';
import 'notification_manager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();

    debugPrint('### [CallbackDispatcher] بدء تنفيذ المهمة: $task');
    debugPrint('### بيانات الإدخال: ${inputData?.toString()}');

    try {
      if (task == 'khatma_reminder') {
        // استخراج البيانات
        final khatmaId = inputData?['khatmaId'] as int?;
        final khatmaName = inputData?['khatmaName'] as String?;
        final creationTimeStr = inputData?['creationTime'] as String?;

        if (khatmaId == null) {
          debugPrint('### خطأ: khatmaId غير موجود');
          return false;
        }

        // تهيئة Supabase
        await Supabase.initialize(
          url: dotenv.env['SUPABASE_URL']!,
          anonKey: dotenv.env['SUPABASE_KEY']!,
        );

        // إعادة الجدولة للمهمة اليومية
        if (creationTimeStr != null) {
          final creationTime = DateTime.parse(creationTimeStr);
          await NotificationService.scheduleKhatmaNotification(
            khatmaId: khatmaId,
            creationTime: creationTime,
            khatmaName: khatmaName ?? 'ختمة القرآن',
          );
        }

        // عرض الإشعار
        await NotificationManager.showNotification(
          title: 'تذكير ختمة القرآن',
          body: 'حان وقت قراءة جزء من ختمة "${khatmaName ?? ''}"',
        );

        return true;
      }
      return false;
    } catch (e, stack) {
      debugPrint('### [CallbackDispatcher] خطأ جسيم: $e');
      debugPrint('### StackTrace: $stack');
      return false;
    }
  });
}
