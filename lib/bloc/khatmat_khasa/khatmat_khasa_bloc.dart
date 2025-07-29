import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:serag_app/model/khatmat_khasa_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/notification_service.dart';

part 'khatmat_khasa_event.dart';
part 'khatmat_khasa_state.dart';

class KhatmatKhasaBloc extends Bloc<KhatmatKhasaEvent, KhatmatKhasaState> {
  final SupabaseClient supabase;
  KhatmatKhasaBloc(this.supabase) : super(KhatmatKhasaInitial()) {
    on<AddKhatmaKhasaEvent>(_addKhatma);
    on<LoadKhatmatKhasaEvent>(_loadKhatmas);
    on<ReservePartEvent>(_reservePart);
  }

  Future<void> _addKhatma(
      AddKhatmaKhasaEvent event, Emitter<KhatmatKhasaState> emit) async {
    emit(KhatmaKhasaLoading());
    try {
      final response = await supabase
          .from('khatmat_khasa')
          .insert(event.khatma.toMap())
          .select()
          .single();

      final newKhatma = KhatmatKhasaModel.fromMap(response);

      // جدولة الإشعارات للختمة الجديدة
      await NotificationService.scheduleDailyReminder(
        khatmaId: newKhatma.id!,
        creationTime: DateTime.parse(response['created_at']),
      );

      emit(KhatmaKhasaLoaded(khatmats: await _fetchKhatmas()));
    } catch (e) {
      emit(KhatmaKhasaError(
        message: 'فشل الإضافة: ${e.toString()}',
      ));
    }
  }

  Future<void> _loadKhatmas(
      LoadKhatmatKhasaEvent event, Emitter<KhatmatKhasaState> emit) async {
    emit(KhatmaKhasaLoading());
    try {
      final response = await supabase.from('khatmat_khasa').select();
      final khatmas =
          (response as List).map((e) => KhatmatKhasaModel.fromMap(e)).toList();
      emit(KhatmaKhasaLoaded(khatmats: khatmas));
    } catch (e) {
      emit(KhatmaKhasaError(
        message: e.toString(),
      ));
    }
  }

  // Future<void> _reservePart(
  //     ReservePartEvent event, Emitter<KhatmatKhasaState> emit) async {
  //   try {
  //     if (event.khatma.id == null) {
  //       emit(KhatmaKhasaError(message: 'معرف الختمة غير موجود'));
  //       return;
  //     }
  //
  //     final response = await supabase
  //         .from('khatmat_khasa')
  //         .select()
  //         .eq('id', event.khatma.id)
  //         .single();
  //
  //     if (response == null) {
  //       emit(KhatmaKhasaError(message: 'الختمة غير موجودة'));
  //       return;
  //     }
  //
  //     final currentKhatma = KhatmatKhasaModel.fromMap(response);
  //
  //     final updatedParts = List<int>.from(currentKhatma.reserved_parts);
  //     if (!updatedParts.contains(event.partNumber)) {
  //       updatedParts.add(event.partNumber);
  //     }
  //
  //     await supabase.from('khatmat_khasa').update({
  //       'reserved_parts': updatedParts,
  //     }).eq('id', event.khatma.id);
  //
  //     add(LoadKhatmatKhasaEvent());
  //   } catch (e) {
  //     emit(KhatmaKhasaError(message: 'فشل حجز الجزء: ${e.toString()}'));
  //   }
  // }

  Future<void> _reservePart(
    ReservePartEvent event,
    Emitter<KhatmatKhasaState> emit,
  ) async {
    emit(KhatmaKhasaLoading()); // إظهار حالة التحميل

    try {
      // 1. التحقق من صحة الختمة
      if (event.khatma.id == null) {
        emit(KhatmaKhasaError(message: 'معرف الختمة غير صالح'));
        return;
      }

      // 2. جلب أحدث بيانات الختمة من Supabase
      final currentData = await supabase
          .from('khatmat_khasa')
          .select('reserved_parts')
          .eq('id', event.khatma.id!)
          .single();

      final currentParts = List<int>.from(currentData['reserved_parts'] ?? []);

      // 3. التحقق من عدم تكرار الجزء
      if (currentParts.contains(event.partNumber)) {
        emit(KhatmaKhasaError(message: 'هذا الجزء محجوز مسبقاً'));
        return;
      }

      // 4. تحديث البيانات
      final updatedParts = [...currentParts, event.partNumber];
      await supabase
          .from('khatmat_khasa')
          .update({'reserved_parts': updatedParts}).eq('id', event.khatma.id!);

      // 5. التحقق من اكتمال الختمة
      if (updatedParts.length >= 30) {
        await NotificationService.cancelReminder(event.khatma.id!);
        emit(KhatmaKhasaSuccess(khatmats: []));
      }

      // 6. إعادة تحميل البيانات
      add(LoadKhatmatKhasaEvent());
    } catch (e) {
      debugPrint('Reserve Part Error: $e');
      emit(KhatmaKhasaError(
        message: 'حدث خطأ أثناء حجز الجزء: ${e.toString()}',
      ));
    }
  }

  Future<List<KhatmatKhasaModel>> _fetchKhatmas() async {
    final response = await supabase.from('khatmat_khasa').select();
    return (response as List).map((e) => KhatmatKhasaModel.fromMap(e)).toList();
  }
}
