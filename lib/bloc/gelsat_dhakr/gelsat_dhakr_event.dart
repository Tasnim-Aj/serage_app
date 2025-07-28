part of 'gelsat_dhakr_bloc.dart';

@immutable
sealed class GelsatDhakrEvent {}

class AddDhakrEvent extends GelsatDhakrEvent {
  final GelsatDhakrModel dhakr;

  AddDhakrEvent({required this.dhakr});
}

class LoadGelsatDhakrEvent extends GelsatDhakrEvent {}
