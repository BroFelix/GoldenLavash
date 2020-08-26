import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:golden_app/models/estimate.dart';

@immutable
abstract class HomeState {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInit extends HomeState {}

class HomeLoadEstimate extends HomeState {
  final estimateResponse;

  HomeLoadEstimate(this.estimateResponse);
}

class HomeLoadOrganisations extends HomeState {}

class HomeLoadOutlay extends HomeState {
  final expense;
  HomeLoadOutlay(this.expense);
}

class HomeLoadProducts extends HomeState {}

class HomeLoadProvider extends HomeState {}

class HomeLoadResources extends HomeState {
  final resourceResponse;

  HomeLoadResources(this.resourceResponse);
}

class HomeComplete extends HomeState {}
