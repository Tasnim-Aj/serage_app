import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';

import '../style/app_colors.dart';

class KhatmaPage extends StatelessWidget {
  const KhatmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          DefaultAppbar(title: 'ختمة   1'),
          Container(
            margin: EdgeInsets.only(top: 58.r),
            alignment: Alignment.center,
            width: 311.w,
            height: 63.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFEFAE0),
            ),
            child: Text(
              'ختمة بنية الشفاء ',
              style: GoogleFonts.inter(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                height: 1.0,
                color: DawnColors.textColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 43.r, left: 19.r, right: 19.r),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 11.w,
                    crossAxisCount: 5,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      width: 55.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: DawnColors.textColor3,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.inter(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          height: 1.0,
                          color: DawnColors.textColor,
                        ),
                      ),
                    );
                  }),
            ),
          )
          // Container(
          //   alignment: Alignment.center,
          //   child: Column(
          //     children: List.generate(5, (index) {
          //       final label = '${index + 1}';
          //       return Row(
          //         children: [
          //           Container(
          //             alignment: Alignment.center,
          //             width: 55.w,
          //             height: 65.h,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: DawnColors.textColor3,
          //             ),
          //             child: Text(
          //               label,
          //               style: GoogleFonts.inter(
          //                 fontSize: 25.sp,
          //                 fontWeight: FontWeight.w400,
          //                 letterSpacing: 0,
          //                 height: 1.0,
          //                 color: DawnColors.textColor,
          //               ),
          //             ),
          //           ),
          //         ],
          //       );
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
