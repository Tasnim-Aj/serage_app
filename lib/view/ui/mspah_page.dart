import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';
import '../widgets/default_appbar.dart';

class MspahPage extends StatelessWidget {
  const MspahPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> num = [1, 10, 33, 41, 100, 500, 1000, 'مخصص'];
    double radius = 160.r;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppbar(title: 'سراج'),
              Padding(
                padding: EdgeInsets.only(top: 15.r, right: 15.r),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/Group81.png',
                      height: 52.h,
                      width: 160.w,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 18.r, right: 15.r),
                          child: Text(
                            'الهدف',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: DawnColors.buttonColor,
                              letterSpacing: 0,
                              height: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            right: 10.r,
                          ),
                          child: Text(
                            '100.000',
                            style: TextStyle(
                              // fontSize: 30,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: DawnColors.textColor,
                              letterSpacing: 0.3,
                              height: 0.5,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 40.r,
                ),
                alignment: Alignment.center,
                width: 113.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: DawnColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      'المتبقي',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 0,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '65.000',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 0,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 40.r,
                  top: 14.r,
                ),
                alignment: Alignment.center,
                width: 280.w,
                height: 173.h,
                decoration: BoxDecoration(
                  color: DawnColors.dark,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  'سبحان الله العظيم',
                  style: TextStyle(
                    // fontSize: 30,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 3,
                    height: 5.0,
                  ),
                ),
              ),
              Center(
                child: Container(
                  // margin: EdgeInsets.only(top: 4.r),
                  alignment: Alignment.center,
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/frame_3.png'),
                    ),
                  ),
                  child: Text(
                    '5',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      color: DawnColors.textColor,
                      letterSpacing: 0.3,
                      height: 0.5,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 8.h,
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 369.38.w,
                    height: 356.22.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFF8C7),
                    ),
                  ),
                  for (int i = 0; i < num.length; i++)
                    Transform.translate(
                      offset: Offset(
                        radius * cos(2 * pi * i / num.length + pi / 2),
                        radius * sin(2 * pi * i / num.length + pi / 2),
                      ),
                      child: Transform.rotate(
                        angle: 2 * pi * i / num.length + pi,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            num[i].toString(),
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF412B2D),
                              height: 0.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 41.24.r,
                        right: 41.24.r,
                        top: 34.22.r,
                        bottom: 37.73.r),
                    width: 294.8.w,
                    height: 284.27.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFB994706B),
                    ),
                    child: Image.asset(
                      'assets/icons/mandala.png',
                      height: 212.33.h,
                      width: 212.33.w,
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    width: 63.17.w,
                    height: 63.17.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFF8C7),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: pi / 4,
                            child: Image.asset(
                              'assets/icons/tap.png',
                              height: 26.32.h,
                              width: 23.32.w,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'انقر',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                              color: Color(0xFF412B2D),
                              height: 0.5,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
