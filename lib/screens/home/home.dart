import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/data_init.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/screens/home/components/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dataLoaded = false;

  initData() {
    DataInitialisator.getInstance().then((di) =>
        di.populateCompany().then((com) =>
            di.populateEstimate().then((est) =>
                di.populateProvider()).then((providers) =>
                di.populateProduct().then((product) =>
                    di.populateResource().then((resource) =>
                        di.populateOutlayCategory().then((category) =>
                            di.populateOutlayItem().then((manufactures) =>
                                di.populateEstimateResource().then((estRes) {
                                  di.populateEstimateItem();
                                  setState(() {
                                    dataLoaded = true;
                                  });
                                }))))))));
  }

  User _user;

  @override
  void initState() {
    initData();
    Future.sync(() async {
      _user = User.fromJson(await getUser());
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Golden Lavash'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  dataLoaded = false;
                });
                initData();
              }),
        ],
      ),
      drawer: HomeDrawerScreen(user: _user),
      body: dataLoaded ? Container() : Center(
          child: CircularProgressIndicator()),
    );
  }
}
