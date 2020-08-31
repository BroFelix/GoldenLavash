import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/save_logout.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/bloc/home/home.dart';

class HomeDrawerScreen extends StatefulWidget {
  final bloc;

  HomeDrawerScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _HomeDrawerScreenState();
}

class _HomeDrawerScreenState extends State<HomeDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white24),
            accountName: Text('Admin',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(14))),
            currentAccountPicture: Container(
              height: ScreenUtil().setHeight(72),
              width: ScreenUtil().setWidth(72),
              child: Image.asset('images/icon.png'),
            ),
            accountEmail: null,
          ),
          ListTile(
            title: Text(
              'Продукты',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToProducts());
            },
          ),
          ListTile(
            title: Text(
              'Outlay Category',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToOutlay());
            },
          ),
          ListTile(
            title: Text(
              'Сырьё',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToResources());
            },
          ),
          ListTile(
            title: Text(
              'Закупки',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToEstimate());
            },
          ),
          ListTile(
            title: Text(
              'Поставщик',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToProvider());
            },
          ),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Log out',
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            ),
            onTap: () {
              Navigator.pop(context);
              saveLogout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
