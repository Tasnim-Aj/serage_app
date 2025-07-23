import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppbar extends StatelessWidget {
  String title;

  DefaultAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: pi / 2,
            child: Image.asset(
              'assets/icons/floral_design.png',
              width: 30.w,
              height: 30.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Transform.rotate(
            angle: -pi / 2,
            child: Image.asset(
              'assets/icons/floral_design.png',
              width: 30.w,
              height: 30.h,
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
