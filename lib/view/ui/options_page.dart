// lib/view/pages/options_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';

import '../style/app_colors.dart';

class OptionsPage extends StatelessWidget {
  final String title;
  final List<Widget> options;

  const OptionsPage({super.key, required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppbar(title: 'سراج'),
          Stack(
            children: [
              Column(
                children: [
                  _buildNoteBox(),
                  SizedBox(height: 30.h),
                  Container(
                    width: 348.w,
                    height: 122.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DawnColors.dark,
                    ),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: DawnColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 456.r,
                left: 20.r,
                right: 20.r,
                child: Column(
                  children: options,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteBox() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 144.r),
          padding: EdgeInsets.symmetric(horizontal: 14.r),
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
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: DawnColors.textColor,
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/star5.png'),
              ),
            ),
            child: Text(
              'ملاحظة',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
