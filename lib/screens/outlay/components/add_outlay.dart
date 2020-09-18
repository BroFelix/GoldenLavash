import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:golden_app/data/db/model/outlay_category.dart' as categoryDb;

class AddOutlayPage extends StatefulWidget {
  final Function(int statusCode) onSubmitted;

  AddOutlayPage({@required this.onSubmitted});

  @override
  State<StatefulWidget> createState() => _AddOutLayoutState();
}

class _AddOutLayoutState extends State<AddOutlayPage> {
  TextEditingController categoryTitleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить Outlay'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
                vertical: ScreenUtil().setHeight(24)),
            child: TextField(
              controller: categoryTitleController,
              decoration: InputDecoration(
                labelText: 'Название категории',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          RaisedButton(
            color: AppColors.buttonColor,
            textColor: Colors.white,
            child: Text(
              'Сохранить',
              style: AppStyles.buttonTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(24)),
            ),
            onPressed: () {
              OutlayCategory outlayCategory =
                  new OutlayCategory(title: categoryTitleController.text);
              Future.sync(() async {
                http.Response response = await ApiService.getInstance()
                    .sendOutlayCategory(outlayCategory);
                if (response.statusCode == 200 || response.statusCode==201) {
                  var category = OutlayCategory.fromJson(
                      json.decode(utf8.decode(response.bodyBytes)));
                  await Floor.instance.database.then((db) =>
                      db.outlayCategoryDao.insertOutlayCategory(
                          categoryDb.OutlayCategory.fromJson(
                              category.toJson())));
                  widget.onSubmitted(response.statusCode);
                }
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
