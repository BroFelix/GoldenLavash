import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:golden_app/bloc/home/home_event.dart';
import 'package:golden_app/bloc/home/home_state.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/persistence/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = Repository();

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  HomeState get initialState => HomeInit();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeGoToEstimate) {
      // yield initialState;
      final estimateResponse = await repository.fetchEstimate();
      yield HomeLoadEstimate(estimateResponse);
    } else if (event is HomeGoToOrganisations) {
      // yield initialState;
      yield HomeLoadOrganisations();
    } else if (event is HomeGoToOutlay) {
      // yield initialState;
      final expense = await repository.fetchExpense();
      yield HomeLoadOutlay(expense);
    } else if (event is HomeGoToProducts) {
      // yield initialState;
      yield HomeLoadProducts();
    } else if (event is HomeGoToProvider) {
      // yield initialState;
      yield HomeLoadProvider();
    } else if (event is HomeGoToResources) {
      // yield initialState;
      final resource = await repository.fetchResource();
      yield HomeLoadResources(resource);
    } else if (event is HomeComplete) {}
  }
}
