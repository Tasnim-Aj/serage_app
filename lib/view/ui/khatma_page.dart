import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';

import '../../bloc/khatmat_khasa/khatmat_khasa_bloc.dart';
import '../style/app_colors.dart';

class KhatmaPage extends StatelessWidget {
  const KhatmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Directionality(
              textDirection: TextDirection.rtl,
              child: DefaultAppbar(title: 'ختمة 1')),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 41.65.r,
                ),
                // padding: EdgeInsets.only(
                //   left: 11,
                // ),
                // alignment: Alignment.centerLeft,
                alignment: Alignment.center,
                width: 311.w,
                height: 63.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFEFAE0),
                ),

                child: Text(
                  'ختمة بنية الشفاء',
                  style: GoogleFonts.inter(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    height: 1.0,
                    color: DawnColors.textColor,
                  ),
                ),
              ),
              Positioned(
                top: 19.84.r,
                left: 248.17.r,
                child: Container(
                  width: 100.27.w,
                  height: 100.27.h,
                  decoration: BoxDecoration(
                    // shape: BoxShape.values[],
                    // color: Colors.red,
                    // color: Color(0xFFFEFAE0),
                    // shape: BoxShape.circle,

                    image: DecorationImage(
                      image: AssetImage(
                        'assets/icons/star5.png',
                      ),
                      fit: BoxFit.contain,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ختمة',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: Colors.white,
                          letterSpacing: 0,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: Colors.white,
                          letterSpacing: 0,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(top: 27.73.r, left: 19.r, right: 19.r),
                child: BlocBuilder<KhatmatKhasaBloc, KhatmatKhasaState>(
                  builder: (context, state) {
                    return GridView.builder(
                      itemCount: 30,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20.r,
                        crossAxisSpacing: 11.r,
                      ),
                      itemBuilder: (context, index) {
                        final isReserved = state.reservedParts.contains(index);

                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<KhatmatKhasaBloc>()
                                  .add(ReservePartEvent(index));
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Container(
                                    padding: EdgeInsets.only(top: 17.r),
                                    width: 256.w,
                                    height: 212.h,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/icons/done.png',
                                          width: 141.w,
                                          height: 100.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          'تم حجز الجزء بنجاح !',
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.0,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            // right: 27.r,
                                            top: 17.r,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              'تم',
                                              style: GoogleFonts.inter(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                                height: 1.0,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 55.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: isReserved
                                    ? Color(0xFFD5D5D5)
                                    : DawnColors.textColor3,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.inter(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing: 0.0,
                                  color: DawnColors.textColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
