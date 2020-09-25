import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/save_logout.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/estimate/estimate.dart';
import 'package:golden_app/screens/login/login.dart';
import 'package:golden_app/screens/outlay/outlay.dart';
import 'package:golden_app/screens/provider/provider.dart';
import 'package:golden_app/screens/qr_screen/qr_screen.dart';
import 'package:golden_app/screens/resource/resource_kitchen.dart';
import 'package:golden_app/screens/resource/resource_part.dart';

class HomeDrawerScreen extends StatefulWidget {
  final User user;

  HomeDrawerScreen({@required this.user});

  @override
  State<StatefulWidget> createState() => _HomeDrawerScreenState();
}

class _HomeDrawerScreenState extends State<HomeDrawerScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white24),
            accountName: Text(
                widget.user != null
                    ? '${widget.user.firstName} ${widget.user.lastName}'
                    : 'UserName Unknown',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(32))),
            currentAccountPicture: Container(
              height: ScreenUtil().setHeight(72),
              width: ScreenUtil().setWidth(72),
              child: Image.asset('images/icon.png'),
            ), accountEmail: null,
          ),
          ListTile(
            title: Text(
              'Закупки',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EstimatePage.route);
            },
          ),
          ListTile(
            title: Text(
              'Поставщики',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProviderPage.route);
            },
          ),
          ListTile(
            title: Text(
              'Категория расходов',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OutlayPage.route);
            },
          ),
          ExpansionTile(
            title: Text(
              'Сырьё',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            children: [
              ListTile(
                title: Text('Сырьё кухня'),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ResourceKitchenPage.route);
                },
              ),
              ListTile(
                title: Text('Сырьё запчасти'),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushNamed(ResourcePartsPage.route);
                },
              ),
            ],
          ),
          widget.user != null
              ? widget.user.userType == 'admin'
                  ? ListTile(
                      title: Text(
                        'Отсканировать продукт',
                        style: AppStyles.drawerTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrScannerPage()));
                        // Navigator.pop(context);
                      },
                    )
                  : Container()
              : Container(),
          Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              'Выход',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: new Text('Выйти из аккаунта'),
                        actions: <Widget>[
                          new FlatButton(
                              onPressed: () async {
                                await saveLogout();
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushReplacementNamed(LoginScreen.route);
                              },
                              child: new Text('Да')),
                          new FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: new Text('Нет'))
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
