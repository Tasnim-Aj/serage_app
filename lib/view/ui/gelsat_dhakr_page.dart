import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_colors.dart';

class GelsatDhakrPage extends StatelessWidget {
  const GelsatDhakrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 27.r),
            child: Text(
              'جلسات الذكر',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: DawnColors.textColor,
                letterSpacing: 0,
                height: 1.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(left: 25.r, right: 25.r, bottom: 24.r),
                    width: 309.w,
                    height: 214.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DawnColors.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 35.r, left: 12.r, right: 5.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'جلسة',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '  صلاة عالنبي    ',
                                style: GoogleFonts.inter(
                                  fontSize: 25.sp,
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
                          margin: EdgeInsets.only(top: 29.r),
                          width: 279.w,
                          height: 1.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: DawnColors.dark,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.r, right: 15.r, top: 8.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'تاريخ البدء',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.r,
                                  ),
                                  Text(
                                    '15\\1\\2020',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'تاريخ الانتهاء',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.r,
                                  ),
                                  Text(
                                    '19\\1\\2020',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.r, right: 15.r, top: 12.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'المنجز',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.r,
                                  ),
                                  Text(
                                    '2000',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'المفروض',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.r,
                                  ),
                                  Text(
                                    '10000',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
                                      letterSpacing: 0,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
