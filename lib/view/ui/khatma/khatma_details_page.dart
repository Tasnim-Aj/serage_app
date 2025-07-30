import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/model/khatma_model.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';
import 'package:share_plus/share_plus.dart';

import '../../../bloc/khatma/khatma_bloc.dart';
import '../../../model/daily_schedule_entry_model.dart';
import '../../style/app_colors.dart';

class KhatmaDetailsPage extends StatelessWidget {
  final KhatmaModel khatma;
  const KhatmaDetailsPage({super.key, required this.khatma});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                          '${khatma.id}',
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
                child: BlocBuilder<KhatmaBloc, KhatmaState>(
                  builder: (context, state) {
                    if (state is KhatmaLoaded || state is KhatmaSuccess) {
                      final khatmats = (state is KhatmaLoaded)
                          ? state.khatmas
                          : (state as KhatmaSuccess).khatmas;

                      final khatmaUpdated = khatmats.firstWhere(
                        (k) => k.id == khatma.id,
                        orElse: () => khatma,
                      );

                      return ListView.builder(
                        itemCount: khatmaUpdated.daily_schedule?.length ?? 0,
                        itemBuilder: (context, dayIndex) {
                          final day = khatmaUpdated.daily_schedule![dayIndex];
                          final date = day.date;
                          final parts = day.parts;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      date,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share,
                                          color:
                                              Theme.of(context).primaryColor),
                                      onPressed: () {
                                        final message = buildMessageForDay(
                                            khatmaUpdated, day);
                                        Share.share(message);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: parts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, partIndex) {
                                    final part = parts[partIndex];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${part.part}'),
                                          Text('${part.person}'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
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
      ),
    );
  }
}

String buildMessageForDay(KhatmaModel khatma, DailyScheduleEntry day) {
  final buffer = StringBuffer();

  buffer.writeln('📖 ختمة: ${khatma.name}');
  buffer.writeln('📅 التاريخ: ${day.date}');
  buffer.writeln('');

  for (final part in day.parts) {
    buffer.writeln('الجزء ${part.part}: ${part.person}');
  }

  return buffer.toString();
}
