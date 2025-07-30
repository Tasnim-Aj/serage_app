import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/view/style/gradient_background.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../bloc/khatma/khatma_bloc.dart';
import '../../../model/daily_schedule_entry_model.dart';
import '../../../model/khatma_model.dart';
import '../../../model/parts_distribution_model.dart';
import '../../style/app_colors.dart';
import '../../widgets/default_appbar.dart';
import 'khatma_details_page.dart';

class AlKhatmatPage extends StatelessWidget {
  // final List<String> initialParticipants;
  // final int initialParticipantsNum;

  const AlKhatmatPage({
    super.key,
    // required this.initialParticipantsNum,
    // required this.initialParticipants
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          KhatmaBloc(Supabase.instance.client)..add(LoadKhatmasEvent()),
      child: _AlKhatmatView(
          // initialParticipantsNum: initialParticipantsNum,
          // initialParticipants: initialParticipants,
          ),
    );
  }
}

class _AlKhatmatView extends StatelessWidget {
  final int initialParticipantsNum = 1;
  final List<String> initialParticipants = ['a'];
  final TextEditingController _personsController = TextEditingController();
  final List<String> _intentions = [
    'قضاء حاجة',
    'تفريج هم',
    'على روح مسلم',
    'شفاء مريض',
    'تيسير أمر',
  ];
  @override
  Widget build(BuildContext context) {
    final khatmaBloc = BlocProvider.of<KhatmaBloc>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              DefaultAppbar(title: 'الختمات'),
              Expanded(
                child: BlocConsumer<KhatmaBloc, KhatmaState>(
                  listener: (context, state) {
                    if (state is KhatmaError) {
                      debugPrint(state.message);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is KhatmaSuccess) {
                      khatmaBloc.add(LoadKhatmasEvent());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const GradientBackground(
                      //         child: CreateKhatmaPage(name: ,)),
                      //   ),
                      // );

                      // Navigator.pop(context); // إغلاق الـ BottomSheet أولاً
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('تمت إضافة الختمة بنجاح')),
                      // );
                    }
                  },
                  builder: (context, state) {
                    print('Current state: $state');
                    if (state is KhatmaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is KhatmaError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is KhatmaLoaded) {
                      if (state.khatmas.isEmpty) {
                        return const Center(child: Text('لا توجد ختمات متاحة'));
                      }
                      return ListView.builder(
                        itemCount: state.khatmas.length,
                        itemBuilder: (context, index) {
                          final khatma = state.khatmas[index];
                          // print('Khatma data: ${khatma.toMap()}');
                          return _buildKhatmaItem(context, khatma, index);
                        },
                      );
                    }

                    return const Center(child: Text('جارٍ تحميل البيانات...'));
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _showAddKhatmaBottomSheet(context, khatmaBloc);
                  },
                  backgroundColor: Theme.of(context).cardColor,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddKhatmaBottomSheet(BuildContext context, KhatmaBloc bloc) {
    String? selectedIntention;
    DateTimeRange? selectedDateRange;
    bool isFajri = false;
    final TextEditingController participantsNumController =
        TextEditingController();
    final TextEditingController participantsController =
        TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: DawnColors.dark,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: 48.r, left: 50.r, top: 21.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // حقل النية
                            Text(
                              'النية',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 20.h),
                            DropdownButtonFormField<String>(
                              value: selectedIntention,
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: _intentions
                                  .map((intent) => DropdownMenuItem<String>(
                                        value: intent,
                                        child: Text(intent,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setModalState(() {
                                  selectedIntention = value;
                                });
                              },
                            ),
                            SizedBox(height: 27.h),

                            // حقل مدة الختمة
                            Text(
                              'مدة الختمة',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () async {
                                final DateTimeRange? picked =
                                    await showDateRangePicker(
                                  context: context,
                                  initialDateRange: selectedDateRange,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: DawnColors.primary,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null) {
                                  setModalState(() {
                                    selectedDateRange = picked;
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 266.71.w,
                                height: 39.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  selectedDateRange == null
                                      ? 'اختر تاريخ البدء والانتهاء'
                                      : _formatDateRange(selectedDateRange!),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // خيار الفجرية
                            Row(
                              children: [
                                Checkbox(
                                  value: isFajri,
                                  onChanged: (bool? value) {
                                    setModalState(() {
                                      isFajri = value ?? false;
                                    });
                                  },
                                  activeColor: DawnColors.primary,
                                ),
                                Text(
                                  'فجرية',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    height: 1.0,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            // حقل عدد المشاركين
                            Text(
                              'عدد المشاركين',
                              style: GoogleFonts.inter(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                height: 1.0,
                                color: DawnColors.textColor3,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            TextField(
                              controller: participantsNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            // حقل أسماء المشاركين
                            Text(
                              'أسماء المشاركين',
                              style: GoogleFonts.inter(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                height: 1.0,
                                color: DawnColors.textColor3,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            TextField(
                              controller: participantsController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // زر الإضافة
                            InkWell(
                              onTap: () {
                                if (selectedIntention == null ||
                                    selectedDateRange == null ||
                                    participantsNumController.text.isEmpty ||
                                    participantsController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'الرجاء إدخال جميع البيانات المطلوبة'),
                                    ),
                                  );
                                  return;
                                }

                                final participantsCount = int.tryParse(
                                    participantsNumController.text);
                                if (participantsCount == null ||
                                    participantsCount < 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('الرجاء إدخال عدد مشاركين صحيح'),
                                    ),
                                  );
                                  return;
                                }
                                final participants = participantsController.text
                                    .split('/')
                                    .map((name) => name.trim())
                                    .where((name) => name.isNotEmpty)
                                    .toList();

                                final distribution = distributeParts(
                                  startDate: selectedDateRange!.start,
                                  endDate: selectedDateRange!.end,
                                  participants: participantsController.text
                                      .split('/')
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList(),
                                );

                                final khatma = KhatmaModel(
                                  id: 1,
                                  name: selectedIntention!,
                                  start_date: selectedDateRange!.start
                                      .toIso8601String(),
                                  end_date:
                                      selectedDateRange!.end.toIso8601String(),
                                  total_persons: participantsCount,
                                  participants: participants,
                                  is_fajri: isFajri,
                                  parts_distribution:
                                      (distribution['parts_distribution']
                                              as List)
                                          .map((e) =>
                                              PartDistributionEntry.fromMap(e))
                                          .toList(),
                                  daily_schedule: (distribution[
                                          'daily_schedule'] as List)
                                      .map((e) => DailyScheduleEntry.fromMap(e))
                                      .toList(),
                                );

                                bloc.add(AddKhatmaEvent(khatma));

                                Navigator.pop(
                                    context); // إغلاق البوتوم شيت بعد الإضافة
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 32.r),
                                alignment: Alignment.center,
                                width: 296.05.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: DawnColors.primary,
                                ),
                                child: const Text('إضافة'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _formatDateRange(DateTimeRange range) {
    return "${range.start.day}/${range.start.month}/${range.start.year} - "
        "${range.end.day}/${range.end.month}/${range.end.year}";
  }

  Widget _buildKhatmaItem(BuildContext context, KhatmaModel khatma, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GradientBackground(
                child: KhatmaDetailsPage(
              khatma: khatma,
            )),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 25.r, right: 25.r, bottom: 24.r),
        width: 309.w,
        height: 195.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.r, left: 12.r, right: 5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 90.62.h,
                    width: 89.82.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                        'assets/icons/star5.png',
                      )),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ختمة',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: 0.0,
                          ),
                        ),
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    khatma.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4.18.r),
              width: 279.w,
              height: 1.h,
              color: Theme.of(context).cardColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('تاريخ البدء',
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 9.r),
                      Text(
                        _formatDate(khatma.start_date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/icons/floral.png',
                    width: 51.w,
                    height: 28.h,
                  ),
                  Column(
                    children: [
                      Text('تاريخ الانتهاء',
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 9.r),
                      Text(_formatDate(khatma.end_date),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

Map<String, dynamic> distributeParts({
  required DateTime startDate,
  required DateTime endDate,
  required List<String> participants,
}) {
  const totalParts = 30;
  final dayCount = endDate.difference(startDate).inDays + 1;
  final List<Map<String, dynamic>> partsDistribution = [];
  final Map<String, List<Map<String, dynamic>>> dayMap = {};

  for (int i = 0; i < totalParts; i++) {
    final partNumber = i + 1;
    final personIndex = i % participants.length;
    final dayOffset = i % dayCount;
    final assignedDate = startDate.add(Duration(days: dayOffset));
    final dateKey =
        "${assignedDate.year}-${assignedDate.month.toString().padLeft(2, '0')}-${assignedDate.day.toString().padLeft(2, '0')}";

    final partEntry = {
      'part': partNumber,
      'person': participants[personIndex],
      'date': dateKey,
    };

    partsDistribution.add(partEntry);

    if (!dayMap.containsKey(dateKey)) {
      dayMap[dateKey] = [];
    }
    dayMap[dateKey]!.add({
      'part': partNumber,
      'person': participants[personIndex],
    });
  }

  final dailySchedule = dayMap.entries
      .map((entry) => {
            'date': entry.key,
            'parts': entry.value,
          })
      .toList();

  return {
    'parts_distribution': partsDistribution,
    'daily_schedule': dailySchedule,
  };
}
