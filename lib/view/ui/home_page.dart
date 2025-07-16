import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';

import '../style/app_colors.dart';
import '../style/gradient_background.dart';
import 'al_khatmat_page.dart';
import 'khatma_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showKhatmaOptions = false;
  bool showtespeehOptions = false;
  final GlobalKey _khatmaButtonKey = GlobalKey();
  final GlobalKey _tespeehButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          DefaultAppbar(title: 'سراج'),
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 144.r),
                        padding: EdgeInsets.only(left: 14.r, right: 11.r),
                        alignment: Alignment.center,
                        width: 309.w,
                        height: 151.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: DawnColors.primary,
                        ),
                        child: Text(
                          ' المستخدم عند الفجر يعرض فقط \n '
                          'الأوراد و الختم الفجرية ،\n'
                          ' و ما بقي من اليوم يعرض الأوراد و \n '
                          'الختم الاخرى',
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: DawnColors.textColor,
                            letterSpacing: 0,
                            height: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        child: Container(
                          alignment: Alignment.center,
                          width: 68.w,
                          height: 68.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              'assets/icons/star5.png',
                            ),
                          )),
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
                      color: DawnColors.dark,
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
                                GradientBackground(child: KhatmaPage())));
                      }),
                      SizedBox(height: 14.95.h),
                      _buildMainButton('ختمة عامة', 'assets/icons/group41.png',
                          () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                GradientBackground(child: AlKhatmatPage())));
                      }),
                    ],
                  ),
                ),
              if (showtespeehOptions)
                Padding(
                  padding: EdgeInsets.only(top: 456.r, left: 15.r),
                  child: Column(
                    children: [
                      _buildMainButton(
                          'جلسة ذكر', 'assets/icons/meeting.png', () {}),
                      SizedBox(height: 14.95.h),
                      _buildMainButton(
                          'مسابقة بذِكر', 'assets/icons/counter.png', () {}),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
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
          color: DawnColors.primary,
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
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                color: DawnColors.textColor,
                letterSpacing: 0,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKhatmaOption(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          showKhatmaOptions = false;
        });
      },
      child: Container(
        width: 100.w,
        height: 95.05.h,
        decoration: BoxDecoration(
          color: DawnColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: DawnColors.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
