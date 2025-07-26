import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts([GoogleFonts.inter()]);
  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];
  if (supabaseUrl == null || supabaseKey == null) {
    throw Exception('Supabase URL or Key not found in .env file');
  }
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  Workmanager().registerPeriodicTask(
    "1",
    "showNotificationTask",
    frequency: const Duration(hours: 15),
    initialDelay: const Duration(seconds: 10),
    constraints: Constraints(networkType: NetworkType.not_required),
  );

  NotificationManager.showNotification();
  tz.initializeTimeZones();

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
              create: (context) => KhatmatKhasaBloc(Supabase.instance.client),
            ),
            BlocProvider(
              create: (context) =>
                  KhatmaBloc(Supabase.instance.client)..add(LoadKhatmasEvent()),
            ),
            BlocProvider(
              create: (context) => KhatmatKhasaBloc(Supabase.instance.client)
                ..add(LoadKhatmatKhasaEvent()),
            ),
          ],
          child: BlocProvider(
            create: (context) => ThemeCubit(),
            // create: (context) => ThemeCubit()..updateThemeBasedOnTime(),
            child: BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, theme) {
                return MaterialApp(
                  theme: theme,
                  debugShowCheckedModeBanner: false,
                  locale: const Locale('ar', ''),
                  home: const GradientBackground(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: HomePage(),
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
