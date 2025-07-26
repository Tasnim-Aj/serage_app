import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serag_app/view/style/gradient_background.dart';
import 'package:serag_app/view/ui/al_khatmat_page.dart';
import 'package:serag_app/view/widgets/default_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/khatma/khatma_bloc.dart';
import '../style/app_colors.dart';

class CreateKhatmaPage extends StatelessWidget {
  const CreateKhatmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KhatmaBloc(Supabase.instance.client),
      child: const _KhatmaKhasaView(),
    );
  }
}

class _KhatmaKhasaView extends StatelessWidget {
  const _KhatmaKhasaView();

  @override
  Widget build(BuildContext context) {
    final TextEditingController personsController = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<KhatmaBloc, KhatmaState>(
            listener: (context, state) {
              if (state is KhatmaError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultAppbar(title: 'ختمة خاصة'),
                    Container(
                      margin:
                          EdgeInsets.only(left: 19.r, right: 19.r, top: 77.r),
                      padding:
                          EdgeInsets.only(left: 25.r, right: 25.r, top: 33.r),
                      width: 323.w,
                      height: 608.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: DawnColors.dark,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'عدد الأشخاص',
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
                            controller: personsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 29.h),
                          GestureDetector(
                            onTap: () {
                              if (personsController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('الرجاء إدخال عدد الأشخاص')),
                                );
                                return;
                              }

                              final persons =
                                  int.tryParse(personsController.text) ?? 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GradientBackground(
                                    child:
                                        AlKhatmatPage(initialPersons: persons),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 257.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: DawnColors.primary,
                              ),
                              child: state is KhatmaLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      'إنشاء و مشاركة',
                                      style: GoogleFonts.inter(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        height: 1.0,
                                        color: DawnColors.textButtonColor,
                                      ),
                                    ),
                            ),
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
      ),
    );
  }
}
