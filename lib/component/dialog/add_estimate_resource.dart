import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart' as resDb;
import 'package:golden_app/model/estimate_resource.dart';
import 'package:golden_app/model/provider.dart' as prov;
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/services/api.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:validators/sanitizers.dart';

class AddResourceDialog extends StatefulWidget {
  final List<Resource> resource;
  final List<prov.Provider> provider;
  final estimateId;
  final Function(int statusCode) onSubmitted;

  AddResourceDialog({
    @required this.estimateId,
    @required this.resource,
    @required this.provider,
    @required this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() => _AddResourceDialogState();
}

class _AddResourceDialogState extends State<AddResourceDialog> {
  GlobalKey<AutoCompleteTextFieldState<String>> GKey1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> Gkey2 = new GlobalKey();

  TextEditingController _productController = new TextEditingController();
  TextEditingController _providerController = new TextEditingController();
  TextEditingController _countController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _priceUsdController = new TextEditingController();
  TextEditingController _rateController = new TextEditingController();

  _AddResourceDialogState();

  User user;
  var productTitle;
  var product;
  var count;
  var pricePerOne;
  prov.Provider provider;

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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        // height: ScreenUtil().setHeight(860),
        width: ScreenUtil().setWidth(600),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
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
                      'Добавить сырьё',
                      textAlign: TextAlign.center,
                      style: AppStyles.dialogTitle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(12)),
              // height: ScreenUtil().setHeight(128),
              // padding: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24), bottom: ScreenUtil().setHeight(12)),
              child: AutoCompleteTextField<String>(
                controller: _productController,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),

                  labelText: 'Продукт',
                ),
                itemSubmitted: (item) {
                  productTitle = item;
                  product = widget.resource
                      .firstWhere((element) => element.title == item);
                  setState(() => _productController.text = item);
                },
                clearOnSubmit: false,
                key: GKey1,
                suggestions: widget.resource.map((e) => e.title).toList(),
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ThousandsFormatter(),
                      ],
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
                    width: ScreenUtil().setWidth(250),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ThousandsFormatter(),
                      ],
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
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
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(12),
                  bottom: ScreenUtil().setHeight(24)),
              // height: ScreenUtil().setHeight(128),
              // padding: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24), bottom: ScreenUtil().setHeight(24)),
              child: AutoCompleteTextField<String>(
                controller: _providerController,
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
                key: Gkey2,
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
                        var priceStr = _priceController.text
                            .replaceAll(RegExp('[,.]'), '');
                        var countStr = _countController.text
                            .replaceAll(RegExp('[,.]'), '');
                        var priceUsd = _priceUsdController.text != ""
                            ? toDouble(_priceUsdController.text)
                            : 0.0;
                        var rate = _rateController.text != ""
                            ? toInt(_rateController.text)
                            : 0;
                        count = countStr != '' ? toInt(countStr) : 0;
                        pricePerOne = priceStr != '' ? toInt(priceStr) : 0;
                        print('$count   $pricePerOne');
                        final resource = new EstimateResource(
                          amount: pricePerOne * count,
                          sendWarehouse: false,
                          status: -1,
                          priceUsd: priceUsd,
                          rate: rate,
                          resource: product.id,
                          estimate: widget.estimateId,
                          price: pricePerOne,
                          provider: provider == null ? null : provider.id,
                          count: count,
                          company: user.company,
                        );
                        Future.sync(() async {
                          http.Response response =
                              await ApiService.getInstance()
                                  .sendEstimateResource(resource);
                          var item = EstimateResource.fromJson(
                              json.decode(utf8.decode(response.bodyBytes)));
                          if (response.statusCode == 200) {
                            await Floor.instance.database.then((database) =>
                                database.estimateResourceDao
                                    .insertEstimateResource(
                                        resDb.EstimateResource.fromJson(
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
            ),
          ],
        ),
      ),
    );
  }
}
