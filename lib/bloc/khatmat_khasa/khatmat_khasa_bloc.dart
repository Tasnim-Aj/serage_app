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

      debugPrint(
          '### [KhatmaBloc] جاري جدولة إشعار للختمة الجديدة ID: ${newKhatma.id}');

      // // جدولة إشعارات للختمة الجديدة
      // await NotificationService.scheduleDailyReminder(
      //   khatmaId: newKhatma.id!,
      //   creationTime: DateTime.parse(response['created_at']),
      // );

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

      // جدولة إشعارات لجميع الختمات
      await NotificationService.scheduleAllKhatmas();

      emit(KhatmaKhasaLoaded(khatmats: khatmas));
    } catch (e) {
      emit(KhatmaKhasaError(
        message: e.toString(),
      ));
    }
  }

  Future<void> _reservePart(
    ReservePartEvent event,
    Emitter<KhatmatKhasaState> emit,
  ) async {
    emit(KhatmaKhasaLoading());

    try {
      if (event.khatma.id == null) {
        emit(KhatmaKhasaError(message: 'معرف الختمة غير صالح'));
        return;
      }

      final currentData = await supabase
          .from('khatmat_khasa')
          .select('reserved_parts')
          .eq('id', event.khatma.id!)
          .single();

      final currentParts = List<int>.from(currentData['reserved_parts'] ?? []);

      if (currentParts.contains(event.partNumber)) {
        emit(KhatmaKhasaError(message: 'هذا الجزء محجوز مسبقاً'));
        return;
      }

      final updatedParts = [...currentParts, event.partNumber];
      await supabase
          .from('khatmat_khasa')
          .update({'reserved_parts': updatedParts}).eq('id', event.khatma.id!);

      if (updatedParts.length >= 30) {
        await NotificationService.cancelReminder(event.khatma.id!);
        emit(KhatmaKhasaSuccess(
          khatmats: await _fetchKhatmas(),
        ));
      } else {
        add(LoadKhatmatKhasaEvent());
      }
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
