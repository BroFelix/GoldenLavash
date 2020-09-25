import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/provider.dart' as provDb;
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api.dart';

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

  User _user;

  @override
  void initState() {
    Future.sync(() async => _user = User.fromJson(await getUser()));
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
                onTap: () => _selectDate(context),
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
                  var name =
                      _nameController.text != null ? _nameController.text : '';
                  var contacts = _contactController.text != null
                      ? _contactController.text
                      : '';
                  var regDate = _dateController.text != null ||
                          _addressController.text != ''
                      ? DateTime.tryParse(_dateController.text)
                      : null;
                  Provider provider = new Provider(
                    name: name,
                    contacts: contacts,
                    registerUser: _user.id,
                    // registerDate: regDate,
                    status: status,
                  );
                  Future.sync(() async {
                    final response = await ApiService.getInstance()
                        .sendProviderById(
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
