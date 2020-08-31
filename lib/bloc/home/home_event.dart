import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class GetData extends HomeEvent {}

class HomeGoToEstimate extends HomeEvent {}

class HomeGoToOutlay extends HomeEvent {}

class HomeGoToProducts extends HomeEvent {}

class HomeGoToProvider extends HomeEvent {}

class HomeGoToResources extends HomeEvent {}

class HomeNavigationComplete extends HomeEvent {}
