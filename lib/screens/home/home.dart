import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/data_init.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/screens/home/components/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dataLoaded = false;
  User _user;

  initData() {
    DataInitialisator.getInstance().then((di) =>
        di.populateCompany().then((com) =>
            di.populateEstimate().then((est) =>
                di.populateProvider()).then((providers) =>
                di.populateProduct().then((product) =>
                    di.populateResource().then((resource) =>
                        di.populateOutlayCategory().then((category) =>
                            di.populateOutlayItem().then((manufactures) =>
                                di.populateEstimateResource()
                                    .then((estRes) {
                                  di.populateEstimateItem();
                                   setState(() => dataLoaded = true);
                                })
                            )))))));
  }

  @override
  void initState() {
    initData();
    Future.sync(() async => _user = User.fromJson(await getUser()));
    super.initState();
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
                Future.sync(() async {
                  var db = await Floor.instance.database;
                  setState(() {
                    dataLoaded = false;
                  });
                  await db.database.execute('PRAGMA foreign_keys = OFF');
                  await db.database.delete('Company');
                  await db.database.delete('Estimate');
                  await db.database.delete('EstimateItem');
                  await db.database.delete('EstimateResource');
                  await db.database.delete('OutlayCategory');
                  await db.database.delete('OutlayItem');
                  await db.database.delete('Product');
                  await db.database.delete('Provider');
                  await db.database.delete('Resource');
                  await initData();
                  await db.database.execute('PRAGMA foreign_keys = ON');
                });
              }),
        ],
      ),
      drawer: HomeDrawerScreen(user: _user),
      body: dataLoaded ? Container() : Center(
          child: CircularProgressIndicator()),
    );
  }
}
