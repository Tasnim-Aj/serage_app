import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/bloc/gelsat_dhakr/gelsat_dhakr_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/gelsat_dhakr_model.dart';
import '../../style/app_colors.dart';
import '../../widgets/default_appbar.dart';

class GelsatDhakrPage extends StatefulWidget {
  const GelsatDhakrPage({super.key});

  @override
  State<GelsatDhakrPage> createState() => _GelsatDhakrPageState();
}

class _GelsatDhakrPageState extends State<GelsatDhakrPage> {
  final List<Map<String, dynamic>> _entries = [];
  final List<String> _intentions = [
    'استغفار',
    'صلاة عالنبي',
    'حوقلة',
    'بسملة',
    'تهليل',
    'تكبير',
    'تسبيح',
  ];

  @override
  Widget build(BuildContext context) {
    final dhakrBloc = BlocProvider.of<GelsatDhakrBloc>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            DefaultAppbar(title: 'جلسات الذكر'),
            Expanded(
              child: BlocConsumer<GelsatDhakrBloc, GelsatDhakrState>(
                listener: (context, state) {
                  if (state is GelsatDhakrSuccess) {
                    dhakrBloc.add(LoadGelsatDhakrEvent());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت إضافة الجلسة بنجاح')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GelsatDhakrError) {
                    print('Error : ${state.message}');
                    return Center(child: Text(state.message));
                  }
                  if (state is GelsatDhakrLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is GelsatDhakrLoaded) {
                    return ListView.builder(
                        itemCount: state.dhakr.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 25.r, right: 25.r, bottom: 24.r),
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
                                      top: 8.r, left: 12.r, right: 5.r),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 90.62.h,
                                        width: 89.82.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icons/star5.png')),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'جلسة',
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
                                        state.dhakr[index].name,
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
                                  margin: EdgeInsets.only(top: 4.18.r),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            state.dhakr[index].start_date,
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
                                      Image.asset(
                                        'assets/icons/floral.png',
                                        width: 51.w,
                                        height: 28.h,
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
                                            state.dhakr[index].end_date,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            state.dhakr[index].required_number
                                                .toString(),
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: DawnColors.textColor2,
                                              letterSpacing: 0,
                                              height: 1.0,
                                            ),
                                          ),
                                          // Text(
                                          //   state.dhakr[index].start_date,
                                          //   style: GoogleFonts.inter(
                                          //     fontSize: 12.sp,
                                          //     fontWeight: FontWeight.w400,
                                          //     color: DawnColors.textColor2,
                                          //     letterSpacing: 0,
                                          //     height: 1.0,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                  return const Center(child: Text('جارٍ تحميل البيانات...'));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  _showAddDhakrBottomSheet(context, dhakrBloc);
                },
                backgroundColor: DawnColors.dark,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareEntries() {
    if (_entries.isEmpty) return;

    final text = _entries.map((e) {
      final name = e['name'];
      final start = e['start'] != null ? _formatDate(e['start']) : '';
      final end = e['end'] != null ? _formatDate(e['end']) : '';
      final fajri = e['fajri'] == true ? '✔️ فجرية' : '❌ غير فجرية';
      return "$name\nمن $start إلى $end\n$fajri";
    }).join('\n\n');

    Share.share(text);
  }

  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  String _formatDateRange(DateTimeRange range) {
    return "${range.end.day}-${range.end.month}-${range.end.year} | "
        "${range.start.day}-${range.start.month}-${range.start.year} ";
  }

  void _showAddDhakrBottomSheet(BuildContext context, GelsatDhakrBloc bloc) {
    String? _selectedIntention;
    DateTimeRange? _selectedDateRange;
    int sliderValue = 50000;
    // List<String> _names = [];
    // int total_persons = 0;
    // TextEditingController _nameController = TextEditingController();
    int _participantsCount = 1;

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
                            Text(
                              'النية',
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            DropdownButtonFormField<String>(
                              value: _selectedIntention,
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
                                  _selectedIntention = value;
                                });
                              },
                            ),
                            SizedBox(height: 27.h),
                            Text(
                              'مدة الختمة',
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () async {
                                final DateTimeRange? picked =
                                    await showDateRangePicker(
                                  context: context,
                                  initialDateRange: _selectedDateRange,
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
                                    _selectedDateRange = picked;
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
                                  _selectedDateRange == null
                                      ? ''
                                      : _formatDateRange(_selectedDateRange!),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor,
                                      height: 1.0,
                                      letterSpacing: 0.0,
                                      fontSize: 20.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 22.h),
                            Text(
                              'العدد المفروض ',
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.0,
                                height: 1.0,
                              ),
                            ),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setModalState) {
                                return Slider(
                                  min: 10000,
                                  max: 100000,
                                  divisions: 9,
                                  value: sliderValue.toDouble(),
                                  label: '${sliderValue.round()}',
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (double newValue) {
                                    setModalState(() {
                                      sliderValue = newValue.round();
                                    });
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 22.h),
                            Text(
                              'عدد المشاركين',
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.0,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                  onPressed: () {
                                    if (_participantsCount > 1) {
                                      setModalState(() => _participantsCount--);
                                    }
                                  },
                                ),
                                Container(
                                  width: 60.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$_participantsCount',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  onPressed: () {
                                    setModalState(() => _participantsCount++);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: InkWell(
                                onTap: _shareEntries,
                                child: Container(
                                  margin: EdgeInsets.only(top: 28.r),
                                  alignment: Alignment.center,
                                  width: 123.w,
                                  height: 29.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFF7D6358)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('assets/icons/sparkling.png'),
                                      Text(
                                        'مشاركة',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          height: 1.0,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (_selectedIntention == null ||
                                    _selectedDateRange == null ||
                                    _participantsCount == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'الرجاء اختيار النية والمدة و عدد المشاركين'),
                                    ),
                                  );
                                  return;
                                }

                                bloc.add(AddDhakrEvent(
                                    dhakr: GelsatDhakrModel(
                                  name: _selectedIntention!,
                                  start_date:
                                      _selectedDateRange!.start.toString(),
                                  end_date: _selectedDateRange!.end.toString(),
                                  total_persons: _participantsCount,
                                  required_number: sliderValue,
                                )));

                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 26.34.r),
                                alignment: Alignment.center,
                                width: 296.05.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: DawnColors.primary),
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
}
