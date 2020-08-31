import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/bloc/home/home.dart';
import 'package:golden_app/screens/home/components/drawer.dart';
import 'package:golden_app/screens/home/components/pages/estimate.dart';
import 'package:golden_app/screens/home/components/pages/outlay.dart';
import 'package:golden_app/screens/home/components/pages/products.dart';
import 'package:golden_app/screens/home/components/pages/provider.dart';
import 'package:golden_app/screens/home/components/pages/resources.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc(HomeInit());

  @override
  void initState() {
    super.initState();
    bloc.add(GetData());
  }

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
            return Container();
          } else if (state is HomeLoadEstimate) {
            return EstimatePage(estimateResponse: state.estimateResponse);
          } else if (state is HomeLoadResources) {
            return ResourcesPage(resources: state.resources);
          } else if (state is HomeLoadProvider) {
            return ProviderPage(
              providers: state.provider,
            );
          } else if (state is HomeLoadProducts) {
            return ProductsPage(
              products: state.products,
            );
          } else if (state is HomeLoadOutlay) {
            return OutlayPage(outlayResponse: state.outlay);
          }
          bloc.add(HomeNavigationComplete());
          return Center(child: Text('Default'));
        },
      ),
    );
  }
}
