part of 'khatmat_khasa_bloc.dart';

@immutable
sealed class KhatmatKhasaEvent {}

class ReservePartEvent extends KhatmatKhasaEvent {
  final KhatmatKhasaModel khatma;
  final int partNumber;

  ReservePartEvent({required this.khatma, required this.partNumber});
}

class AddKhatmaKhasaEvent extends KhatmatKhasaEvent {
  final KhatmatKhasaModel khatma;

  AddKhatmaKhasaEvent({required this.khatma});
}

class LoadKhatmatKhasaEvent extends KhatmatKhasaEvent {}
