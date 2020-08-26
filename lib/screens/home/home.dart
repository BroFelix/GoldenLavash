import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/bloc/home/bloc.dart';
import 'package:golden_app/screens/home/components/drawer.dart';
import 'package:golden_app/screens/home/components/estimate.dart';
import 'package:golden_app/screens/home/components/outlay.dart';
import 'package:golden_app/screens/home/components/resources.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc(HomeInit());

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: BlocProvider(
        create: (context) => bloc,
        child: HomeDrawerScreen(bloc),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (prev, next) {
          return prev != next;
        },
        cubit: bloc,
        builder: (BuildContext context, HomeState state) {
          if (state is HomeInit) {
            return Center(
              child: Text('HomeInit'),
            );
          }
          if (state is HomeLoadEstimate) {
            return EstimateScreen(estimateResponse: state.estimateResponse);
          }
          if (state is HomeLoadResources) {
            return ResourcesScreen(resourceResponse: state.resourceResponse);
          }
          if (state is HomeLoadOrganisations) {
            return Center(
              child: Text('Organisations'),
            );
          }
          if (state is HomeLoadProvider) {
            return Center(
              child: Text('Provider'),
            );
          }
          if (state is HomeLoadProducts) {
            return Center(
              child: Text('Products'),
            );
          }
          if (state is HomeLoadOutlay) {
            return OutlayScreen(expenseResponse: state.expense);
          }
          bloc.add(HomeNavigationComplete());
          return Center(child: Text('Default'));
        },
      ),
    );
  }
}
