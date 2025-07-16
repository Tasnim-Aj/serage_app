import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'khatmat_khasa_event.dart';
part 'khatmat_khasa_state.dart';

class KhatmatKhasaBloc extends Bloc<KhatmatKhasaEvent, KhatmatKhasaState> {
  KhatmatKhasaBloc() : super(KhatmatKhasaInitial()) {
    on<ReservePartEvent>((event, emit) {
      final currentReserved = Set<int>.from(state.reservedParts);
      currentReserved.add(event.index);
      emit(KhatmatKhasaUpdatedState(reservedParts: currentReserved));
    });
  }
}
