import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serag_app/model/khatmat_khasa_model.dart';
import 'package:serag_app/view/style/app_colors.dart';
import 'package:serag_app/view/style/gradient_background.dart';
import 'package:serag_app/view/ui/khatma_page.dart';

import '../../bloc/khatmat_khasa/khatmat_khasa_bloc.dart';
import '../widgets/default_appbar.dart';

class KhatmatKhasaPage extends StatelessWidget {
  KhatmatKhasaPage({super.key});

  final List<String> _intentions = [
    'قضاء حاجة',
    'تفريج هم',
    'على روح مسلم',
    'شفاء مريض',
    'تيسير أمر',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            DefaultAppbar(title: 'الختمات'),
            Expanded(
              child: BlocBuilder<KhatmatKhasaBloc, KhatmatKhasaState>(
                builder: (context, state) {
                  if (state is KhatmaKhasaLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is KhatmaKhasaError) {
                    debugPrint('Error : ${state.message}');
                    return Center(child: Text(state.message));
                  }
                  if (state is KhatmaKhasaLoaded) {
                    return ListView.builder(
                      itemCount: state.khatmats.length,
                      itemBuilder: (context, index) {
                        return _buildKhatmaItem(
                            context, state.khatmats[index], index);
                      },
                    );
                  }
                  return Text('لا توجد بيانات');
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _showAddKhatmaBottomSheet(
                      context, context.read<KhatmatKhasaBloc>());
                },
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.add,
                  color: DawnColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKhatmaItem(
      BuildContext context, KhatmatKhasaModel khatma, int index) {
    int parts = khatma.reserved_parts.length;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GradientBackground(
              child: KhatmaPage(
                khatma: khatma,
              ),
            ),
          ),
        ).then((_) {
          context.read<KhatmatKhasaBloc>().add(LoadKhatmatKhasaEvent());
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 25.r, right: 25.r, bottom: 24.r),
        width: 309.w,
        height: 295.h,
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
                          style: TextStyle(
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
              padding: EdgeInsets.only(top: 8.r, left: 12.r, right: 12.r),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      parts < 30
                          ? Text('الختمة غير منتهية')
                          : Text('الختمة منتهية'),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Wrap(
                    spacing: 6.0.w,
                    runSpacing: 4.0.h,
                    children:
                        _getUnreservedParts(khatma.reserved_parts).map((part) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          part.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddKhatmaBottomSheet(BuildContext context, KhatmatKhasaBloc bloc) {
    String? _selectedIntention;

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
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
                              style: Theme.of(context).textTheme.titleMedium,
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
                            BlocConsumer<KhatmatKhasaBloc, KhatmatKhasaState>(
                              listener: (context, state) {
                                if (state is KhatmaKhasaError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
                                // if (state is KhatmaKhasaSuccess) {
                                //   Navigator.pop(context);
                                //   BlocProvider.of<KhatmatKhasaBloc>(context)
                                //       .add(LoadKhatmatKhasaEvent());
                                // }

                                if (state is KhatmaKhasaLoaded) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                return InkWell(
                                  onTap: state is KhatmaKhasaLoading
                                      ? null // تعطيل الزر أثناء التحميل
                                      : () {
                                          if (_selectedIntention == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'الرجاء اختيار النية')),
                                            );
                                            return;
                                          }
                                          bloc.add(AddKhatmaKhasaEvent(
                                            khatma: KhatmatKhasaModel(
                                              id: 1,
                                              name: _selectedIntention!,
                                              reserved_parts: [],
                                            ),
                                          ));
                                        },
                                  // onTap: () {
                                  //   if (_selectedIntention == null) {
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(
                                  //       const SnackBar(
                                  //           content:
                                  //               Text('الرجاء اختيار النية')),
                                  //     );
                                  //     return;
                                  //   }
                                  //   if (state is KhatmaKhasaLoading) {
                                  //     Center(
                                  //         child: CircularProgressIndicator());
                                  //   }
                                  //
                                  //   bloc.add(AddKhatmaKhasaEvent(
                                  //     khatma: KhatmatKhasaModel(
                                  //       name: _selectedIntention!,
                                  //       reserved_parts: [],
                                  //     ),
                                  //   ));
                                  // },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 32.r),
                                      alignment: Alignment.center,
                                      width: 296.05.w,
                                      height: 44.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: state is KhatmaKhasaLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white)
                                          : Text('إضافة')),
                                );
                              },
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

  List<int> _getUnreservedParts(List<dynamic> reservedParts) {
    var allParts = List<int>.generate(30, (i) => i + 1); // من 1 إلى 30
    final reserved = reservedParts.cast<int>().toSet(); // تحويل لقائمة أرقام
    return allParts.where((part) => !reserved.contains(part)).toList();
  }
}
