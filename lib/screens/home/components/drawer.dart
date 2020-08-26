import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/bloc/home/bloc.dart';

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
            accountEmail: Text('@mail.ru'),
            accountName: Text('Admin'),
          ),
          ListTile(
            title: Text(
              'Организации',
              style: AppStyles.drawerTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(22)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              widget.bloc.add(HomeGoToOrganisations());
            },
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
        ],
      ),
    );
  }
}
