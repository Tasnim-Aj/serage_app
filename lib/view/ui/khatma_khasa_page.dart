import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_colors.dart';

class KhatmaKhasaPage extends StatefulWidget {
  const KhatmaKhasaPage({super.key});

  @override
  State<KhatmaKhasaPage> createState() => _KhatmaKhasaPageState();
}

class _KhatmaKhasaPageState extends State<KhatmaKhasaPage> {
  List<bool> checkedOptions = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'ختمة   خاصة',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 23.sp,
                letterSpacing: 0,
                height: 1.0,
                color: DawnColors.textColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.only(left: 19.r, right: 19.r, top: 77.r),
            padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 33.r),
            width: 323.w,
            height: 608.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: DawnColors.dark,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عدد الأشخاص',
                  style: GoogleFonts.inter(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    height: 1.0,
                    color: DawnColors.textColor3,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  'اسماء المشتركين',
                  style: GoogleFonts.inter(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    height: 1.0,
                    color: DawnColors.textColor3,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 29.h,
                ),
                Text(
                  'عدد الأجزاء لكل شخص',
                  style: GoogleFonts.inter(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    height: 1.0,
                    color: DawnColors.textColor3,
                  ),
                ),
                SizedBox(
                  height: 17.h,
                ),
                Column(
                  children: List.generate(3, (index) {
                    final label = '${index + 1}'
                        // ' ${index == 0 ? '' : ' (أجزاء)'}'
                        ;
                    return Row(
                      children: [
                        Checkbox(
                          fillColor: MaterialStateProperty.all(Colors.white),
                          checkColor: DawnColors.dark,
                          value: checkedOptions[index],
                          onChanged: (bool? value) {
                            setState(() {
                              checkedOptions[index] = value ?? false;
                            });
                          },
                          activeColor: DawnColors.buttonColor,
                        ),
                        Text(
                          label,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: Colors.white,
                            letterSpacing: 0,
                            height: 1.0,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                // SizedBox(
                //   height: 88.h,
                // ),
                Container(
                  alignment: Alignment.center,
                  width: 257.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DawnColors.buttonColor,
                  ),
                  child: Text(
                    'إنشاء و مشاركة',
                    style: GoogleFonts.inter(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      height: 1.0,
                      color: DawnColors.textButtonColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
