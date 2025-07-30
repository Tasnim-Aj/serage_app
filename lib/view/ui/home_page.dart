import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serag_app/view/ui/dhaker/gelsat_dhakr_page.dart';
import 'package:serag_app/view/ui/dhaker/mspah_page.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';

import '../../cubit/theme_cubit.dart';
import '../style/gradient_background.dart';
import 'khatma/al_khatmat_page.dart';
import 'khatma/khatmat_khasa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showKhatmaOptions = false;
  bool showtespeehOptions = false;
  final GlobalKey _khatmaButtonKey = GlobalKey();
  final GlobalKey _tespeehButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ThemeCubit>().updateThemeBasedOnTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          DefaultAppbar(
            title: 'سراج',
          ),
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 144.r),
                        alignment: Alignment.center,
                        width: 309.w,
                        height: 151.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          ' المستخدم عند الفجر يعرض فقط \n '
                          'الأوراد و الختم الفجرية ،\n'
                          ' و ما بقي من اليوم يعرض الأوراد و \n '
                          'الختم الاخرى',
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        top: 110.r,
                        left: 272.r,
                        child: Container(
                          width: 68.w,
                          height: 68.h,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/star5.png'),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'ملاحظة',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Colors.white,
                              letterSpacing: 0,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.r, left: 6.r, right: 6.r),
                    width: 348.w,
                    height: 122.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMainButton('ختمة', 'assets/icons/series.png', () {
                          setState(() {
                            showKhatmaOptions = !showKhatmaOptions;
                          });
                        }, key: _khatmaButtonKey),
                        _buildMainButton(
                            'سورة', 'assets/icons/quran.png', () {}),
                        _buildMainButton('تسبيح', 'assets/icons/beads.png', () {
                          setState(() {
                            showtespeehOptions = !showtespeehOptions;
                          });
                        }, key: _tespeehButtonKey),
                      ],
                    ),
                  ),
                ],
              ),
              if (showKhatmaOptions)
                Padding(
                  padding: EdgeInsets.only(top: 456.r, right: 15.r),
                  child: Column(
                    children: [
                      _buildMainButton('ختمة خاصة', 'assets/icons/series.png',
                          () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                GradientBackground(child: KhatmatKhasaPage())));
                      }),
                      SizedBox(height: 14.95.h),
                      _buildMainButton('ختمة عامة', 'assets/icons/group41.png',
                          () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GradientBackground(
                                child: AlKhatmatPage(
                                    // initialParticipantsNum: 1,
                                    // initialParticipants: ["مشارك افتراضي"],
                                    ))));
                      }),
                    ],
                  ),
                ),
              if (showtespeehOptions)
                Padding(
                  padding: EdgeInsets.only(top: 456.r, left: 15.r),
                  child: Column(
                    children: [
                      _buildMainButton('جلسة ذكر', 'assets/icons/meeting.png',
                          () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GradientBackground(
                                child: GelsatDhakrPage())));
                      }),
                      SizedBox(height: 14.95.h),
                      _buildMainButton(
                          'مسابقة بذِكر', 'assets/icons/counter.png', () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const GradientBackground(child: MspahPage())));
                      }),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // اختبار وضع الفجر المزيف
          // context.read<ThemeCubit>().updateThemeBasedOnTime(simulateTest: true);
          context.read<ThemeCubit>().updateThemeBasedOnTime();
        },
        child: const Icon(Icons.access_time),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.read<ThemeCubit>().toggleTheme(),
      //   child: Icon(
      //     context.watch<ThemeCubit>().state == AppThemes.darkTheme
      //         ? Icons.light_mode
      //         : Icons.dark_mode,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Widget _buildMainButton(String text, String image, VoidCallback onTap,
      {Key? key}) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 95.05.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 38,
              height: 38,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}
