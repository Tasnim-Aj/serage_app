import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serag_app/model/gelsat_dhakr_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'gelsat_dhakr_event.dart';
part 'gelsat_dhakr_state.dart';

class GelsatDhakrBloc extends Bloc<GelsatDhakrEvent, GelsatDhakrState> {
  final SupabaseClient supabase;
  GelsatDhakrBloc(this.supabase) : super(GelsatDhakrInitial()) {
    on<AddDhakrEvent>(_addDhakr);
    on<LoadGelsatDhakrEvent>(_loadDhakr);
  }

  Future<void> _addDhakr(
      AddDhakrEvent event, Emitter<GelsatDhakrState> emit) async {
    emit(GelsatDhakrLoading());
    try {
      await supabase.from('jalsat_dhukir').insert(event.dhakr.toMap());
      emit(GelsatDhakrSuccess(dhakr: const []));
      emit(GelsatDhakrLoading());
    } catch (e) {
      emit(GelsatDhakrError(message: 'فشل الإضافة: ${e.toString()}'));
    }
  }

  Future<void> _loadDhakr(
      LoadGelsatDhakrEvent event, Emitter<GelsatDhakrState> emit) async {
    emit(GelsatDhakrLoading());
    try {
      final response = await supabase.from('jalsat_dhukir').select();
      print('Supabase response: $response');
      final dhakr =
          (response as List).map((e) => GelsatDhakrModel.fromMap(e)).toList();
      emit(GelsatDhakrLoaded(dhakr: dhakr));
    } catch (e) {
      print('Error :$e');
      emit(GelsatDhakrError(message: e.toString()));
    }
  }
}
