import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../style/app_colors.dart';
import '../widgets/default_appbar.dart';

class AlKhatmatPage extends StatefulWidget {
  AlKhatmatPage({super.key});

  @override
  State<AlKhatmatPage> createState() => _AlKhatmatPageState();
}

class _AlKhatmatPageState extends State<AlKhatmatPage> {
  final List<Map<String, dynamic>> _entries = [];
  String? _selectedIntention;
  final List<String> _intentions = [
    'قضاء حاجة',
    'تفريج هم',
    'على روح مسلم',
    'شفاء مريض',
    'تيسير أمر',
  ];
  DateTimeRange? _selectedDateRange;
  bool _isFajri = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultAppbar(title: 'الختمات'),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(left: 25.r, right: 25.r, bottom: 24.r),
                    width: 309.w,
                    height: 195.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DawnColors.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.r, left: 12.r, right: 5.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 90.62.h,
                                width: 89.82.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/star5.png')),
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
                                      '1',
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
                                'ختمة بنية الشفاء',
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
                          color: DawnColors.dark,
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
                                    ),
                                  ),
                                  SizedBox(height: 9.r),
                                  Text(
                                    '15\\1\\2020',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
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
                                    ),
                                  ),
                                  SizedBox(height: 9.r),
                                  Text(
                                    '19\\1\\2020',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: DawnColors.textColor2,
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    color: DawnColors.dark,
                                  ),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 48.r, left: 50.r, top: 21.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            items: _intentions
                                                .map((intent) =>
                                                    DropdownMenuItem<String>(
                                                      value: intent,
                                                      child: Text(intent,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
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
                                                initialDateRange:
                                                    _selectedDateRange,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.light(
                                                        primary:
                                                            DawnColors.primary,
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Text(
                                                _selectedDateRange == null
                                                    ? ''
                                                    : _formatDateRange(
                                                        _selectedDateRange!),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: DawnColors.textColor,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: _isFajri,
                                                onChanged: (bool? value) {
                                                  setModalState(() {
                                                    _isFajri = value ?? false;
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
                                                    letterSpacing: 0.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                          Center(
                                            child: InkWell(
                                              onTap: _shareEntries,
                                              child: Container(
                                                // alignment: Alignment.center,
                                                width: 123.w,
                                                height: 29.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color(0xFF7D6358)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                        'assets/icons/sparkling.png'),
                                                    Text(
                                                      'مشاركة',
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15.sp,
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        height: 1.0,
                                                      ),
                                                    ),
                                                    Icon(
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
                                              if (_selectedIntention != null) {
                                                setState(() {
                                                  _entries.add({
                                                    'name': _selectedIntention,
                                                    'start': _selectedDateRange
                                                        ?.start,
                                                    'end':
                                                        _selectedDateRange?.end,
                                                    'fajri': _isFajri,
                                                  });
                                                });
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(top: 32.r),
                                              alignment: Alignment.center,
                                              width: 296.05.w,
                                              height: 44.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      DawnColors.buttonColor),
                                              child: Text('إضافة'),
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
                },
                backgroundColor: DawnColors.primary,
                child: Icon(Icons.add, color: Colors.white),
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
}
