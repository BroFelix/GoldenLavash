import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/provider.dart' as provDb;
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api/api.dart';
import 'package:http/http.dart' as http;

class EditProviderPage extends StatefulWidget {
  final provider;
  final Function(int statusCode) onSubmit;

  EditProviderPage({@required this.provider, @required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _EditProviderState();
}

class _EditProviderState extends State<EditProviderPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _innController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  bool status = true;

  @override
  void initState() {
    _nameController.text = widget.provider.name;
    _contactController.text = widget.provider.contacts;
    _addressController.text = widget.provider.address;
    _innController.text = widget.provider.itn;
    status = widget.provider.status;
    _userController.text = widget.provider.registerUser.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изменить поставщика'),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Имя поставщика',
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Контакты',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Дата регистрации',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Зарегистрированый User'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              alignment: Alignment.centerLeft,
              // width: ScreenUtil().setWidth(256),
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
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(8)),
              child: TextField(
                controller: _innController,
                decoration: InputDecoration(
                    labelText: 'ИНН',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(16)),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: 'Адрес',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: RaisedButton(
                color: AppColors.buttonColor,
                textColor: Colors.white,
                child: Text('Сохранить'),
                onPressed: () {
                  Provider provider = new Provider(
                    name: _nameController.text,
                    contacts: _contactController.text,
                    registerDate: DateTime.parse(_dateController.text),
                    status: status,
                  );
                  Future.sync(() async {
                    final http.Response response =
                        await ApiService.getInstance().sendProviderById(
                            provider: provider, id: widget.provider.id);
                    if (response.statusCode == 200) {
                      await Floor.instance.database.then((db) => db.providerDao
                          .insertProvider(provDb.Provider.fromJson(
                              json.decode(utf8.decode(response.bodyBytes)))));
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
