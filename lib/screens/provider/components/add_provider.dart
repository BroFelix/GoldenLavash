import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:golden_app/data/db/model/provider.dart' as dbProv;
import 'package:geolocator/geolocator.dart';

class AddProviderPage extends StatefulWidget {
  final Function(int statusCode) onSubmit;

  AddProviderPage({@required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _AddProviderState();
}

class _AddProviderState extends State<AddProviderPage> {
  bool status = true;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _innController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  User user;
  LocationPermission permission;
  Position position;

  @override
  void initState() {
    getUser().then((currentUser) => user = User.fromJson(currentUser));
    // Future.delayed(Duration.zero, () async {
    //   permission = await checkPermission();
    // });
    Future.sync( () async {
      position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null)
        setState(() {
          _dateController.text = picked.toString().split(' ')[0];
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить Поставщика'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24),
                  bottom: ScreenUtil().setHeight(8)),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Имя поставщика',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Контакты',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                onTap: () => _selectDate(context),
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Дата регистрации',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ИНН',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Адрес',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              // width: ScreenUtil().setWidth(256),
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(16)),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                  child: Text('Status',
                      style: AppStyles.contentTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(24))),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(200),
                ),
                Checkbox(
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    }),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: RaisedButton(
                color: AppColors.buttonColor,
                textColor: Colors.white,
                child: Text(
                  'Сохранить',
                  style: AppStyles.buttonTextStyle
                      .copyWith(fontSize: ScreenUtil().setSp(24)),
                ),
                onPressed: () {
                  // print(user.id);
                  Provider provider = new Provider(
                    name: _nameController.text,
                    contacts: _contactController.text,
                    registerDate: DateTime.parse(_dateController.text),
                    status: status,
                    registerUser: user.id,
                    itn: _innController.text ?? _innController.text,
                    address: _addressController.text ?? _addressController.text,
                    latitude:
                        position != null ? position.latitude.toString() : "",
                    longitude:
                        position != null ? position.longitude.toString() : "",
                  );
                  Future.sync( () async {
                    http.Response response =
                        await ApiService.getInstance().sendProvider(provider);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      var provider = Provider.fromJson(
                          json.decode(utf8.decode(response.bodyBytes)));
                      await Floor.instance.database.then((db) {
                        db.providerDao.insertProvider(
                            dbProv.Provider.fromJson(provider.toJson()));
                      });
                      widget.onSubmit(response.statusCode);
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
