part of 'gelsat_dhakr_bloc.dart';

@immutable
sealed class GelsatDhakrState {}

final class GelsatDhakrInitial extends GelsatDhakrState {}

class GelsatDhakrLoading extends GelsatDhakrState {}

class GelsatDhakrLoaded extends GelsatDhakrState {
  final List<GelsatDhakrModel> dhakr;

  GelsatDhakrLoaded({required this.dhakr});

  @override
  List<Object?> get props => [dhakr];
}

class GelsatDhakrError extends GelsatDhakrState {
  final String message;

  GelsatDhakrError({required this.message});
}

class GelsatDhakrSuccess extends GelsatDhakrState {
  final List<GelsatDhakrModel> dhakr;

  GelsatDhakrSuccess({required this.dhakr});
}
