import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate_item.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api.dart';
import 'package:validators/sanitizers.dart';
import 'package:http/http.dart' as http;

class ChangeCount extends StatelessWidget {
  final item;
  final String type;
  final Function(int statusCode) onSubmit;

  final TextEditingController _textEditingController = TextEditingController();

  ChangeCount(
      {@required this.item, @required this.type, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: ScreenUtil().setHeight(380),
        width: ScreenUtil().setWidth(600),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
              decoration: BoxDecoration(
                color: AppColors.dialogTitleColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(children: [
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(64),
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(24),
                      top: ScreenUtil().setHeight(12)),
                  child: Text(
                    'Изменить количество',
                    textAlign: TextAlign.center,
                    style: AppStyles.dialogTitle
                        .copyWith(fontSize: ScreenUtil().setSp(26)),
                  ),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setWidth(24),
                  horizontal: ScreenUtil().setWidth(24)),
              child: TextField(
                onSubmitted: (value) {
                  item.count = toInt(value);
                },
                onEditingComplete: () {
                  item.count = toInt(_textEditingController.text);
                },
                keyboardType: TextInputType.number,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Количество',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Divider(height: 1.0, color: Colors.black),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(180),
                    margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(24),
                        top: ScreenUtil().setHeight(16)),
                    child: RaisedButton(
                      textColor: Colors.white,
                      hoverColor: AppColors.dialogCloseButtonHover,
                      color: AppColors.dialogCloseButton,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Закрыть',
                          style: AppStyles.buttonTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(24))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(16),
                        right: ScreenUtil().setWidth(24)),
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(180),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.buttonColor,
                      hoverColor: AppColors.buttonColorHover,
                      child: Text('Добавить',
                          style: AppStyles.buttonTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(24))),
                      onPressed: () {
                        if (_textEditingController.text != null &&
                            _textEditingController != null)
                          item.count = toInt(_textEditingController.text);

                        Future.sync(() async {
                          http.Response response;
                          var db = await Floor.instance.database;
                          var countItem;
                          switch (type) {
                            case 'estimateResource':
                              response = await ApiService.getInstance()
                                  .sendEstimateResource(item);
                              countItem = EstimateResource.fromJson(
                                  json.decode(utf8.decode(response.bodyBytes)));
                              if (response.statusCode == 200) {
                                await db.estimateResourceDao
                                    .insertEstimateResource(countItem);
                              }
                              break;
                            case 'estimateItem':
                              response = await ApiService.getInstance()
                                  .sendEstimateItem(item);
                              countItem = EstimateItem.fromJson(
                                  json.decode(utf8.decode(response.bodyBytes)));
                              if (response.statusCode == 200) {
                                await db.estimateItemDao
                                    .insertEstimateItem(countItem);
                              }
                              break;
                          }
                          onSubmit(response.statusCode);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
