// void _showAddDhakrBottomSheet(BuildContext context, GelsatDhakrBloc bloc) {
//   String? _selectedIntention;
//   DateTimeRange? _selectedDateRange;
//   int sliderValue = 50000;
//   // List<String> _names = [];
//   // int total_persons = 0;
//   // TextEditingController _nameController = TextEditingController();
//   int _participantsCount = 1;
//
//   showModalBottomSheet(
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setModalState) {
//           return DraggableScrollableSheet(
//             initialChildSize: 0.6,
//             maxChildSize: 0.9,
//             expand: false,
//             builder: (context, scrollController) {
//               return Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                     color: DawnColors.dark,
//                   ),
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     child: Padding(
//                       padding:
//                       EdgeInsets.only(right: 48.r, left: 50.r, top: 21.r),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'النية',
//                             style: TextStyle(
//                               fontSize: 23.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                           DropdownButtonFormField<String>(
//                             value: _selectedIntention,
//                             dropdownColor: Colors.white,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             items: _intentions
//                                 .map((intent) => DropdownMenuItem<String>(
//                               value: intent,
//                               child: Text(intent,
//                                   style: const TextStyle(
//                                       color: Colors.black)),
//                             ))
//                                 .toList(),
//                             onChanged: (value) {
//                               setModalState(() {
//                                 _selectedIntention = value;
//                               });
//                             },
//                           ),
//                           SizedBox(height: 27.h),
//                           Text(
//                             'مدة الختمة',
//                             style: TextStyle(
//                               fontSize: 23.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               height: 1.0,
//                               letterSpacing: 0.0,
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                           GestureDetector(
//                             onTap: () async {
//                               final DateTimeRange? picked =
//                               await showDateRangePicker(
//                                 context: context,
//                                 initialDateRange: _selectedDateRange,
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2100),
//                                 builder: (context, child) {
//                                   return Theme(
//                                     data: Theme.of(context).copyWith(
//                                       colorScheme: const ColorScheme.light(
//                                         primary: DawnColors.primary,
//                                         onPrimary: Colors.white,
//                                         onSurface: Colors.black,
//                                       ),
//                                     ),
//                                     child: child!,
//                                   );
//                                 },
//                               );
//                               if (picked != null) {
//                                 setModalState(() {
//                                   _selectedDateRange = picked;
//                                 });
//                               }
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 266.71.w,
//                               height: 39.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Colors.grey),
//                               ),
//                               child: Text(
//                                 _selectedDateRange == null
//                                     ? ''
//                                     : _formatDateRange(_selectedDateRange!),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: DawnColors.textColor,
//                                     height: 1.0,
//                                     letterSpacing: 0.0,
//                                     fontSize: 20.sp),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 22.h),
//                           Text(
//                             'العدد المفروض ',
//                             style: TextStyle(
//                               fontSize: 23.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0.0,
//                               height: 1.0,
//                             ),
//                           ),
//                           // StatefulBuilder(
//                           //   builder: (BuildContext context,
//                           //       StateSetter setModalState) {
//                           //     return Slider(
//                           //       min: 10000,
//                           //       max: 100000,
//                           //       divisions: 9,
//                           //       value: sliderValue
//                           //           .toDouble(), // تحويل int إلى double للسلايدر
//                           //       label: '${sliderValue.round()}',
//                           //       activeColor: Theme.of(context).primaryColor,
//                           //       onChanged: (double newValue) {
//                           //         setModalState(() {
//                           //           sliderValue = newValue
//                           //               .round(); // تحويل double إلى int عند التغيير
//                           //           print('New Value: $sliderValue');
//                           //         });
//                           //       },
//                           //     );
//                           //   },
//                           // ),
//                           SizedBox(height: 22.h),
//                           Text(
//                             'عدد المشاركين',
//                             style: TextStyle(
//                               fontSize: 23.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0.0,
//                               height: 1.0,
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.remove, color: Colors.white),
//                                 onPressed: () {
//                                   if (_participantsCount > 1) {
//                                     setModalState(() => _participantsCount--);
//                                   }
//                                 },
//                               ),
//                               Container(
//                                 width: 60.w,
//                                 padding:
//                                 EdgeInsets.symmetric(horizontal: 12.w),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Text(
//                                   '$_participantsCount',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(fontSize: 18.sp),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.add, color: Colors.white),
//                                 onPressed: () {
//                                   setModalState(() => _participantsCount++);
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           Center(
//                             child: InkWell(
//                               onTap: _shareEntries,
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 28.r),
//                                 alignment: Alignment.center,
//                                 width: 123.w,
//                                 height: 29.h,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: const Color(0xFF7D6358)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Image.asset('assets/icons/sparkling.png'),
//                                     Text(
//                                       'مشاركة',
//                                       style: GoogleFonts.inter(
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 15.sp,
//                                         color: Colors.white,
//                                         letterSpacing: 0.0,
//                                         height: 1.0,
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.share,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               if (_selectedIntention == null ||
//                                   _selectedDateRange == null ||
//                                   _participantsCount == null) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text(
//                                         'الرجاء اختيار النية والمدة و عدد المشاركين'),
//                                   ),
//                                 );
//                                 return;
//                               }
//
//                               bloc.add(AddDhakrEvent(
//                                   dhakr: GelsatDhakrModel(
//                                     name: _selectedIntention!,
//                                     start_date:
//                                     _selectedDateRange!.start.toString(),
//                                     end_date: _selectedDateRange!.end.toString(),
//                                     total_persons: _participantsCount,
//                                     required_number: sliderValue,
//                                   )));
//
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(top: 26.34.r),
//                               alignment: Alignment.center,
//                               width: 296.05.w,
//                               height: 44.h,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: DawnColors.primary),
//                               child: const Text('إضافة'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }
