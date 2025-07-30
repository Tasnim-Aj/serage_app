// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:serag_app/view/style/gradient_background.dart';
// import 'package:serag_app/view/ui/khatma/al_khatmat_page.dart';
// import 'package:serag_app/view/widgets/default_appbar.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../../bloc/khatma/khatma_bloc.dart';
// import '../../style/app_colors.dart';
//
// class CreateKhatmaPage extends StatelessWidget {
//   CreateKhatmaPage(
//       {required this.name, required this.date, required this.fajri});
//   String name;
//   DateTimeRange date;
//   bool fajri;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => KhatmaBloc(Supabase.instance.client),
//       child: const _KhatmaKhasaView(),
//     );
//   }
// }
//
// class _KhatmaKhasaView extends StatelessWidget {
//   const _KhatmaKhasaView();
//
//   @override
//   Widget build(BuildContext context) {
//     final khatmaBloc = BlocProvider.of<KhatmaBloc>(context);
//
//     final TextEditingController participantsNumController =
//         TextEditingController();
//     final TextEditingController participantsController =
//         TextEditingController();
//     // final TextEditingController perController = TextEditingController();
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: BlocConsumer<KhatmaBloc, KhatmaState>(
//             listener: (context, state) {
//               if (state is KhatmaError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.message)),
//                 );
//               }
//     if (state is KhatmaSuccess) {
//     khatmaBloc.add(LoadKhatmasEvent());}
//             },
//             builder: (context, state) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     DefaultAppbar(title: 'ختمة خاصة'),
//                     Container(
//                       margin:
//                           EdgeInsets.only(left: 19.r, right: 19.r, top: 77.r),
//                       padding:
//                           EdgeInsets.only(left: 25.r, right: 25.r, top: 33.r),
//                       width: 323.w,
//                       height: 608.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: DawnColors.dark,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'عدد المشاركين',
//                             style: GoogleFonts.inter(
//                               fontSize: 23.sp,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0,
//                               height: 1.0,
//                               color: DawnColors.textColor3,
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                           TextField(
//                             controller: participantsNumController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             'أسماء المشاركين',
//                             style: GoogleFonts.inter(
//                               fontSize: 23.sp,
//                               fontWeight: FontWeight.w400,
//                               letterSpacing: 0,
//                               height: 1.0,
//                               color: DawnColors.textColor3,
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                           TextField(
//                             controller: participantsController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 29.h),
//                           GestureDetector(
//                             onTap: () {
//                               if (participantsNumController.text.isEmpty ||
//                                   participantsController.text.isEmpty) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text(
//                                           'الرجاء إدخال أسماء وعدد المشاركين ')),
//                                 );
//                                 return;
//                               }
//
//                               // final persons = int.tryParse(
//                               //         participantsNumController.text) ??
//                               //     1;
//                               //
//                               // final List<String> participantsList =
//                               //     participantsController.text
//                               //         .split(',')
//                               //         .map((e) => e.trim())
//                               //         .where((e) =>
//                               //             e.isNotEmpty) // تجاهل الأسماء الفارغة
//                               //         .toList();
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => GradientBackground(
//                               //       child: AlKhatmatPage(
//                               //           // initialParticipantsNum: persons,
//                               //           // initialParticipants: participantsList,
//                               //           ),
//                               //     ),
//                               //   ),
//                               // );
//
//                                                             debugPrint('''
//                               بيانات الإضافة:
//                               النية: $selectedIntention
//                               المدة: ${selectedDateRange!.start} إلى ${selectedDateRange!.end}
//                               عدد المشاركين: ${_personsController.text}
//                               المشاركين: $initialParticipants
//                               ''');
//                                                             bloc.add(AddKhatmaEvent(
//                                                               KhatmaModel(
//                                                                 name: selectedIntention!,
//                                                                 start_date:
//                                                                     selectedDateRange!.start.toString(),
//                                                                 end_date: selectedDateRange!.end.toString(),
//                                                                 total_persons:
//                                                                     int.tryParse(_personsController.text) ??
//                                                                         1,
//                                                                 participants: initialParticipants.isNotEmpty
//                                                                     ? initialParticipants
//                                                                     : ['مشارك افتراضي'],
//                                                                 is_fajri: isFajri,
//                                                               ),
//                                                             ));
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 257.w,
//                               height: 42.h,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: DawnColors.primary,
//                               ),
//                               child: state is KhatmaLoading
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white)
//                                   : Text(
//                                       'إنشاء و مشاركة',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 25.sp,
//                                         fontWeight: FontWeight.w400,
//                                         letterSpacing: 0,
//                                         height: 1.0,
//                                         color: DawnColors.textButtonColor,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
