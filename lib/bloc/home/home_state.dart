import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class HomeInit extends HomeState {}

class HomeLoadEstimate extends HomeState {
  final estimateResponse;

  HomeLoadEstimate(this.estimateResponse);
}

class HomeLoadOutlay extends HomeState {
  final outlay;

  HomeLoadOutlay(this.outlay);
}

class HomeLoadProducts extends HomeState {
  final products;

  HomeLoadProducts(this.products);
}

class HomeLoadProvider extends HomeState {
  final provider;

  HomeLoadProvider(this.provider);
}

class HomeLoadResources extends HomeState {
  final resources;

  HomeLoadResources(this.resources);
}

class HomeComplete extends HomeState {}
