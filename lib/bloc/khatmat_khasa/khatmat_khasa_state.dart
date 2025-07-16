part of 'khatmat_khasa_bloc.dart';

@immutable
sealed class KhatmatKhasaState {
  Set<int> get reservedParts => {};
}

final class KhatmatKhasaInitial extends KhatmatKhasaState {}

class KhatmatKhasaUpdatedState extends KhatmatKhasaState {
  final Set<int> reservedParts;

  KhatmatKhasaUpdatedState({required this.reservedParts});
}
