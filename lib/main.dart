import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/bloc/gelsat_dhakr/gelsat_dhakr_bloc.dart';
import 'package:serag_app/bloc/khatma/khatma_bloc.dart';
import 'package:serag_app/cubit/theme_cubit.dart';
import 'package:serag_app/view/ui/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'bloc/khatmat_khasa/khatmat_khasa_bloc.dart';
import 'config/config.dart';
import 'notification/callback_dispatcher.dart';
import 'notification/notification_manager.dart';
import 'view/style/gradient_background.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  // 1. تهيئة Flutter الأساسية
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تحميل الخطوط ومتغيرات البيئة
  await GoogleFonts.pendingFonts([GoogleFonts.inter()]);
  await dotenv.load(fileName: '.env');

  // 3. التحقق من وجود مفاتيح Supabase
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];
  if (supabaseUrl == null || supabaseKey == null) {
    throw Exception('Supabase URL or Key not found in .env file');
  }

  // 4. تهيئة Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // 5. تهيئة الإشعارات والمناطق الزمنية
  await NotificationManager.initializeNotifications();
  tz.initializeTimeZones();

  // 6. تهيئة Workmanager (يجب أن تكون بعد تهيئة Supabase)
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // 7. مهمة بدء تشغيل للتأكد من عمل Workmanager
  Workmanager().registerOneOffTask(
    "init",
    "initBackgroundTask",
    initialDelay: Duration(seconds: 3),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: false,
    ),
    backoffPolicy: BackoffPolicy.exponential,
    backoffPolicyDelay: Duration(seconds: 10),
  );

  // 8. تشغيل التطبيق
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => KhatmatKhasaBloc(Supabase.instance.client)
                ..add(LoadKhatmatKhasaEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  KhatmaBloc(Supabase.instance.client)..add(LoadKhatmasEvent()),
            ),
            BlocProvider(
              create: (context) => GelsatDhakrBloc(Supabase.instance.client)
                ..add(LoadGelsatDhakrEvent()),
            ),
          ],
          child: BlocProvider(
            create: (context) => ThemeCubit(),
            child: BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, theme) {
                return ProviderScope(
                  child: MaterialApp(
                    theme: theme,
                    debugShowCheckedModeBanner: false,
                    locale: const Locale('ar', ''),
                    home: const GradientBackground(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: HomePage(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
