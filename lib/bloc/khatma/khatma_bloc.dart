import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/khatma_model.dart';

part 'khatma_event.dart';
part 'khatma_state.dart';

class KhatmaBloc extends Bloc<KhatmaEvent, KhatmaState> {
  final SupabaseClient supabase;

  KhatmaBloc(this.supabase) : super(KhatmaInitial()) {
    on<AddKhatmaEvent>(_addKhatma);
    on<LoadKhatmasEvent>(_loadKhatmas);
  }

  Future<void> _addKhatma(
      AddKhatmaEvent event, Emitter<KhatmaState> emit) async {
    emit(KhatmaLoading());
    try {
      await supabase.from('khatma').insert(event.khatma.toMap());

      emit(KhatmaSuccess([]));
    } catch (e) {
      emit(KhatmaError('فشل الإضافة: ${e.toString()}'));
    }
  }

  Future<void> _loadKhatmas(
      LoadKhatmasEvent event, Emitter<KhatmaState> emit) async {
    emit(KhatmaLoading());
    try {
      final response = await supabase.from('khatma').select();
      print('Supabase response: $response');
      final khatmas =
          (response as List).map((e) => KhatmaModel.fromMap(e)).toList();
      emit(KhatmaLoaded(khatmas));
    } catch (e) {
      emit(KhatmaError(e.toString()));
    }
  }
}
