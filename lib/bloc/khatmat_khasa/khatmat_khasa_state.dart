part of 'khatmat_khasa_bloc.dart';

@immutable
sealed class KhatmatKhasaState {
  Set<int> get reservedParts => {};
}

final class KhatmatKhasaInitial extends KhatmatKhasaState {}

class KhatmatKhasaUpdatedState extends KhatmatKhasaState {
  @override
  final Set<int> reservedParts;

  KhatmatKhasaUpdatedState({required this.reservedParts});
}

class KhatmaKhasaLoaded extends KhatmatKhasaState {
  final List<KhatmatKhasaModel> khatmats;

  KhatmaKhasaLoaded({required this.khatmats});

  @override
  List<Object?> get props => [khatmats];
}

class KhatmaKhasaLoading extends KhatmatKhasaState {}

class KhatmaKhasaSuccess extends KhatmatKhasaState {
  final List<KhatmatKhasaModel> khatmats;

  KhatmaKhasaSuccess({required this.khatmats});
}

class KhatmaKhasaError extends KhatmatKhasaState {
  final String message;

  KhatmaKhasaError({required this.message});
}
