import 'dart:convert';
import 'dart:core';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate_item.dart' as itemDb;
import 'package:golden_app/model/estimate_item.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/model/provider.dart' as prov;
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validators/sanitizers.dart';

class AddOutlayDialog extends StatefulWidget {
  final List<OutlayCategory> outlayCategory;
  final List<prov.Provider> provider;
  final List<OutlayItem> outlayItems;
  final estimateId;
  final Function onSubmitted;

  AddOutlayDialog({
    @required this.estimateId,
    @required this.outlayCategory,
    @required this.outlayItems,
    this.provider,
    @required this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() => _AddOutlayDialogState();
}

class _AddOutlayDialogState extends State<AddOutlayDialog> {
  GlobalKey<AutoCompleteTextFieldState<String>> Gkey2 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> Gkey3 = new GlobalKey();

  TextEditingController _outlayController = new TextEditingController();
  TextEditingController _providerController = new TextEditingController();
  TextEditingController _countController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _priceUsdController = new TextEditingController();
  TextEditingController _rateController = new TextEditingController();

  _AddOutlayDialogState();

  var outlayItem;
  var count;
  var price;
  prov.Provider provider;
  User user;

  final priceFormatter = new MaskTextInputFormatter();
  var formatter = NumberFormat('#,###.#');

  @override
  void initState() {
    Future.sync(() async {
      user = User.fromJson(await getUser());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> suggestions = widget.outlayItems.map((e) => e.title).toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        // height: ScreenUtil().setHeight(1000),
        width: ScreenUtil().setWidth(600),
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
              decoration: BoxDecoration(
                color: AppColors.dialogTitleColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(64),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(24),
                        top: ScreenUtil().setHeight(12)),
                    child: Text(
                      'Добавить расход',
                      textAlign: TextAlign.center,
                      style: AppStyles.dialogTitle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: ScreenUtil().setHeight(128),
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12),
                  bottom: ScreenUtil().setHeight(8)),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: DropdownButtonFormField<OutlayCategory>(
                isExpanded: true,
                decoration: InputDecoration(
                    labelText: 'Категория',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                items: widget.outlayCategory
                    .map((e) => DropdownMenuItem<OutlayCategory>(
                          value: e,
                          child: Text(e.title),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    suggestions = widget.outlayItems
                        .where((e) => e.outlayCategory == value.id)
                        .map((e) => e.title)
                        .toList();
                    Gkey2.currentState.suggestions = suggestions;
                  });
                },
              ),
            ),
            Container(
              // height: ScreenUtil().setHeight(128),
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: AutoCompleteTextField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  labelText: 'Причина',
                ),
                itemSubmitted: (item) {
                  outlayItem =
                      widget.outlayItems.firstWhere((e) => e.title == item);
                  setState(() => _outlayController.text = item);
                },
                clearOnSubmit: false,
                key: Gkey2,
                suggestions: suggestions,
                itemBuilder: (context, item) {
                  return Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                    height: ScreenUtil().setHeight(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item,
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                        ),
                      ],
                    ),
                  );
                },
                itemSorter: (a, b) {
                  return a.compareTo(b);
                },
                itemFilter: (item, query) {
                  return item.toLowerCase().contains(query.toLowerCase());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // height: ScreenUtil().setHeight(128),
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onSubmitted: (value) {
                        count = toInt(value);
                      },
                      controller: _countController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Количество',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: ScreenUtil().setHeight(128),
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onSubmitted: (value) {
                        count = toInt(value);
                      },
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Цена за единицу',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // height: ScreenUtil().setHeight(128),
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _priceUsdController,
                      decoration: InputDecoration(
                          labelText: 'Цена в USD',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    // height: ScreenUtil().setHeight(128),
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _rateController,
                      decoration: InputDecoration(
                          labelText: 'Курс',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: ScreenUtil().setHeight(128),
              margin: EdgeInsets.only(top:ScreenUtil().setHeight(8),bottom: ScreenUtil().setHeight(24)),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: AutoCompleteTextField<String>(
                controller: _providerController,
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(24)),
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  labelText: 'Поставщик',
                ),
                itemSubmitted: (item) {
                  provider = widget.provider.firstWhere((e) => e.name == item);
                  setState(() => _providerController.text = item);
                },
                clearOnSubmit: false,
                key: Gkey3,
                suggestions: widget.provider.map((e) => e.name).toList(),
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(100),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                        ),
                      ),
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.compareTo(b);
                },
                itemFilter: (item, query) {
                  return item.toLowerCase().contains(query.toLowerCase());
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // height: ScreenUtil().setHeight(64),
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
                      child: Text(
                        'Закрыть',
                        style: AppStyles.buttonTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(16),
                        right: ScreenUtil().setWidth(24)),
                    // height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(180),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.buttonColor,
                      hoverColor: AppColors.buttonColorHover,
                      child: Text(
                        'Добавить',
                        style: AppStyles.buttonTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                      onPressed: () {
                        print(_countController.text);
                        print(_priceController.text);
                        var count = _countController.text != ''
                            ? toInt(_countController.text)
                            : 0;
                        var price = _priceController.text != ''
                            ? toInt(_priceController.text)
                            : 0;
                        var priceUsd = _priceUsdController.text != ""
                            ? toDouble(_priceUsdController.text)
                            : 0.0;
                        var rate = _rateController.text != ""
                            ? toInt(_rateController.text)
                            : 0;
                        print(count * price);
                        int calc = (count * price).floor();
                        final estimateItem = new EstimateItem(
                          amount: calc,
                          status: 0,
                          estimate: widget.estimateId,
                          count: count,
                          price: price,
                          priceUsd: priceUsd,
                          rate: rate,
                          outlayItem: outlayItem.id,
                          company: user.company,
                          provider: provider == null ? null : provider.id,
                        );
                        Future.sync(() async {
                          http.Response response =
                              await ApiService.getInstance()
                                  .sendEstimateItem(estimateItem);
                          var item = EstimateItem.fromJson(
                              json.decode(utf8.decode(response.bodyBytes)));
                          if (response.statusCode == 200) {
                            await Floor.instance.database.then((db) =>
                                db.estimateItemDao.insertEstimateItem(
                                    itemDb.EstimateItem.fromJson(
                                        item.toJson())));
                            widget.onSubmitted(response.statusCode);
                          }
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
