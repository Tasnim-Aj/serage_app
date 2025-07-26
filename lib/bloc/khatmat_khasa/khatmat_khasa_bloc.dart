import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serag_app/model/khatmat_khasa_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      // INSERT بدون id لانها تولد تلقائي
      final insertedRecord = await supabase
          .from('khatmat_khasa')
          .insert(event.khatma.toMap())
          .select()
          .single();

      // حوّل النتيجة لموديل مع id المولّد
      final insertedKhatma = KhatmatKhasaModel.fromMap(insertedRecord);

      final khatmas = await _fetchKhatmas();
      emit(KhatmaKhasaLoaded(khatmats: khatmas));
      // ممكن تبعت insertedKhatma اذا بدك تستخدمه فوراً
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

  Future<void> _reservePart(
      ReservePartEvent event, Emitter<KhatmatKhasaState> emit) async {
    try {
      if (event.khatma.id == null) {
        emit(KhatmaKhasaError(message: 'معرف الختمة غير موجود'));
        return;
      }

      final response = await supabase
          .from('khatmat_khasa')
          .select()
          .eq('id', event.khatma.id)
          .single();

      if (response == null) {
        emit(KhatmaKhasaError(message: 'الختمة غير موجودة'));
        return;
      }

      final currentKhatma = KhatmatKhasaModel.fromMap(response);

      final updatedParts = List<int>.from(currentKhatma.reserved_parts);
      if (!updatedParts.contains(event.partNumber)) {
        updatedParts.add(event.partNumber);
      }

      await supabase.from('khatmat_khasa').update({
        'reserved_parts': updatedParts,
      }).eq('id', event.khatma.id);

      add(LoadKhatmatKhasaEvent());
    } catch (e) {
      emit(KhatmaKhasaError(message: 'فشل حجز الجزء: ${e.toString()}'));
    }
  }

  Future<List<KhatmatKhasaModel>> _fetchKhatmas() async {
    final response = await supabase.from('khatmat_khasa').select();
    return (response as List).map((e) => KhatmatKhasaModel.fromMap(e)).toList();
  }
}
