// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     WidgetsFlutterBinding.ensureInitialized(); // تهيئة Flutter
//     await dotenv.load(); // تحميل متغيرات البيئة
//
//     // تهيئة Supabase هنا (نفس الكود الموجود في main.dart)
//     await Supabase.initialize(
//       url: dotenv.env['SUPABASE_URL']!,
//       anonKey: dotenv.env['SUPABASE_KEY']!,
//     );
//
//     debugPrint('### تم تنفيذ المهمة: ${task}');
//     try {
//       final khatmaId = inputData?['khatmaId'] as int?;
//       if (khatmaId == null) return Future.value(false);
//
//       await NotificationManager.initializeNotifications();
//
//       final isCompleted =
//           await NotificationManager.checkKhatmaCompletion(khatmaId);
//       if (isCompleted) {
//         await Workmanager().cancelByTag('khatma_$khatmaId');
//         return Future.value(true);
//       }
//
//       final khatmaData = await SupabaseService.supabase
//           .from('khatmat_khasa')
//           .select('name')
//           .eq('id', khatmaId)
//           .single();
//
//       await NotificationManager.showNotification(
//         title: 'تذكير يومي للختمة',
//         body: 'حان وقت قراءة جزء من ختمة "${khatmaData['name']}"!',
//       );
//
//       return Future.value(true);
//     } catch (e) {
//       debugPrint('Error in callback: $e');
//       return Future.value(false);
//     }
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'notification_manager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // 1. تهيئة Flutter الأساسية (إجبارية)
      WidgetsFlutterBinding.ensureInitialized();

      // 2. تحميل متغيرات البيئة
      await dotenv.load(fileName: '.env');

      // 3. تهيئة Supabase مع معالجة الأخطاء
      try {
        await Supabase.initialize(
          url: dotenv.env['SUPABASE_URL']!,
          anonKey: dotenv.env['SUPABASE_KEY']!,
          authOptions: const FlutterAuthClientOptions(
            authFlowType: AuthFlowType.pkce,
          ),
        );
        debugPrint('### Supabase تهيئة ناجحة في الخلفية');
      } catch (e) {
        debugPrint('### خطأ في تهيئة Supabase: $e');
        return false;
      }

      // // 4. التحقق من الاتصال بالإنترنت
      // final connectivity = await Connectivity().checkConnectivity();
      // if (connectivity == ConnectivityResult.none) {
      //   debugPrint('### لا يوجد اتصال بالإنترنت');
      //   return false;
      // }

      // 5. معالجة أنواع المهام المختلفة
      switch (task) {
        case 'init_background_task':
          debugPrint('### مهمة التهيئة الخلفية اكتملت');
          return true;

        case 'khatma_reminder':
          final khatmaId = inputData?['khatmaId'] as int?;
          if (khatmaId == null) {
            debugPrint('### خطأ: khatmaId غير موجود');
            return false;
          }

          // 6. عرض الإشعار
          await NotificationManager.showNotification(
            title: 'تذكير الختمة',
            body: 'حان وقت قراءة جزء من القرآن اليوم!',
          );
          debugPrint('### تم إرسال إشعار للختمة $khatmaId');
          return true;

        default:
          debugPrint('### مهمة غير معروفة: $task');
          return false;
      }
    } catch (e, stack) {
      debugPrint('### خطأ جسيم: $e');
      debugPrint('### StackTrace: $stack');
      return false;
    }
  });
}
