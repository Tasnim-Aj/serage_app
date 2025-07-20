// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:serag_app/view/style/gradient_background.dart';
// import 'package:serag_app/view/ui/al_khatmat_page.dart';
// import 'package:serag_app/view/widgets/default_appbar.dart';
//
// import '../style/app_colors.dart';
//
// class KhatmaKhasaPage extends StatefulWidget {
//   const KhatmaKhasaPage({super.key});
//
//   @override
//   State<KhatmaKhasaPage> createState() => _KhatmaKhasaPageState();
// }
//
// class _KhatmaKhasaPageState extends State<KhatmaKhasaPage> {
//   final TextEditingController _personsController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _createKhatma() async {
//     if (_personsController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('الرجاء إدخال عدد الأشخاص')),
//       );
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     try {
//       debugPrint('=== محاولة إنشاء ختمة جديدة ===');
//       debugPrint('قيمة عدد الأشخاص المدخلة: ${_personsController.text}');
//
//       final persons = int.tryParse(_personsController.text) ?? 1;
//       debugPrint('عدد الأشخاص بعد التحويل: $persons');
//
//       debugPrint('الانتقال إلى صفحة AlKhatmatPage...');
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GradientBackground(
//             child: AlKhatmatPage(initialPersons: persons),
//           ),
//         ),
//       );
//
//       debugPrint('تم إنشاء الختمة بنجاح!');
//     } catch (e, stackTrace) {
//       debugPrint('====== خطأ أثناء إنشاء الختمة ======');
//       debugPrint('نوع الخطأ: ${e.runtimeType}');
//       debugPrint('رسالة الخطأ: ${e.toString()}');
//       debugPrint('مسار الخطأ:');
//       debugPrint(stackTrace.toString());
//       debugPrint('==============================');
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 DefaultAppbar(title: 'ختمة خاصة'),
//                 Container(
//                   margin: EdgeInsets.only(left: 19.r, right: 19.r, top: 77.r),
//                   padding: EdgeInsets.only(left: 25.r, right: 25.r, top: 33.r),
//                   width: 323.w,
//                   height: 608.h,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: DawnColors.dark,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'عدد الأشخاص',
//                         style: GoogleFonts.inter(
//                           fontSize: 23.sp,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 0,
//                           height: 1.0,
//                           color: DawnColors.textColor3,
//                         ),
//                       ),
//                       SizedBox(height: 20.h),
//                       TextField(
//                         controller: _personsController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 29.h),
//                       GestureDetector(
//                         onTap: _createKhatma,
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: 257.w,
//                           height: 42.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: DawnColors.buttonColor,
//                           ),
//                           child: _isLoading
//                               ? CircularProgressIndicator(color: Colors.white)
//                               : Text(
//                                   'إنشاء و مشاركة',
//                                   style: GoogleFonts.inter(
//                                     fontSize: 25.sp,
//                                     fontWeight: FontWeight.w400,
//                                     letterSpacing: 0,
//                                     height: 1.0,
//                                     color: DawnColors.textButtonColor,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
