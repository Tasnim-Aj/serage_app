part of 'khatma_bloc.dart';

@immutable
sealed class KhatmaEvent {}

class AddKhatmaEvent extends KhatmaEvent {
  final KhatmaModel khatma;

  AddKhatmaEvent(this.khatma);
}

class LoadKhatmasEvent extends KhatmaEvent {}
