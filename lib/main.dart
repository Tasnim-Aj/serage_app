import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/khatmat_khasa/khatmat_khasa_bloc.dart';
import 'view/style/gradient_background.dart';
import 'view/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts([GoogleFonts.inter()]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => KhatmatKhasaBloc(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale('ar', ''),
            home: GradientBackground(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: HomePage(),
              ),
            ),
          ),
        );
      },
    );
  }
}
