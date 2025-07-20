part of 'khatma_bloc.dart';

@immutable
sealed class KhatmaState {}

final class KhatmaInitial extends KhatmaState {}

class KhatmaLoading extends KhatmaState {}

class KhatmaSuccess extends KhatmaState {
  final List<KhatmaModel> khatmas;

  KhatmaSuccess(this.khatmas);
}

class KhatmaError extends KhatmaState {
  final String message;

  KhatmaError(this.message);
}

class KhatmaLoaded extends KhatmaState {
  final List<KhatmaModel> khatmas;

  KhatmaLoaded(this.khatmas);

  @override
  List<Object?> get props => [khatmas];
}
