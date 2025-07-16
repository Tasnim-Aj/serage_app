part of 'khatmat_khasa_bloc.dart';

@immutable
sealed class KhatmatKhasaEvent {}

class ReservePartEvent extends KhatmatKhasaEvent {
  final int index;
  ReservePartEvent(this.index);
}
