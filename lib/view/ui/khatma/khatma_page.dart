import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/model/khatmat_khasa_model.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../bloc/khatmat_khasa/khatmat_khasa_bloc.dart';
import '../../style/app_colors.dart';

class KhatmaPage extends StatelessWidget {
  final KhatmatKhasaModel khatma;

  const KhatmaPage({super.key, required this.khatma});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = KhatmatKhasaBloc(Supabase.instance.client);
        bloc.add(LoadKhatmatKhasaEvent());
        return bloc;
      },
      child: BlocListener<KhatmatKhasaBloc, KhatmatKhasaState>(
        listener: (context, state) {
          if (state is KhatmaKhasaSuccess) {
            // إغلاق أي dialog مفتوح (مثلاً loading)
            Navigator.of(context, rootNavigator: true).maybePop();

            // عرض رسالة نجاح الحجز
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Container(
                  padding: EdgeInsets.only(top: 17.r),
                  width: 256.w,
                  height: 212.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/done.png',
                        width: 141.w,
                        height: 100.h,
                      ),
                      SizedBox(height: 5.h),
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
                        padding: EdgeInsets.only(top: 17.r),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is KhatmaKhasaError) {
            // إغلاق أي dialog مفتوح لو فيه
            Navigator.of(context, rootNavigator: true).maybePop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: _KhatmaView(khatma: khatma),
      ),
    );
  }
}

class _KhatmaView extends StatelessWidget {
  final KhatmatKhasaModel khatma;

  const _KhatmaView({required this.khatma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultAppbar(title: khatma.name),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(top: 41.65.r),
                alignment: Alignment.center,
                width: 311.w,
                height: 63.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFEFAE0),
                ),
                child: Text(
                  khatma.name,
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/star5.png'),
                      fit: BoxFit.contain,
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
                        '${khatma.reserved_parts.length}',
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
                  if (state is KhatmaKhasaLoaded ||
                      state is KhatmaKhasaSuccess) {
                    // لما الحالة تكون Loaded أو Success، نجيب الـ khatma المحدّث من الـ state لو موجود
                    final khatmats = (state is KhatmaKhasaLoaded)
                        ? state.khatmats
                        : (state as KhatmaKhasaSuccess).khatmats;

                    final khatmaUpdated = khatmats.firstWhere(
                      (k) => k.id == khatma.id,
                      orElse: () => khatma,
                    );

                    return GridView.builder(
                      itemCount: 30,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 20.r,
                        crossAxisSpacing: 11.r,
                      ),
                      itemBuilder: (context, index) {
                        final isReserved =
                            khatmaUpdated.reserved_parts.contains(index + 1);

                        return GestureDetector(
                          onTap: isReserved
                              ? null
                              : () => _reservePart(context, index + 1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isReserved
                                  ? const Color(0xFFFFC3C3)
                                  : const Color(0xFFD5D5D5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text('${index + 1}'),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _reservePart(BuildContext context, int partNumber) {
    context.read<KhatmatKhasaBloc>().add(
          ReservePartEvent(khatma: khatma, partNumber: partNumber),
        );
  }
}
