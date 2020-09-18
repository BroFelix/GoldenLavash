import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/component/dialog/add_estimate_item.dart';
import 'package:golden_app/component/dialog/add_estimate_resource.dart';
import 'package:golden_app/component/dialog/change_count.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate.dart' as estDb;

import 'package:golden_app/model/estimate.dart';
import 'package:golden_app/model/estimate_item.dart';
import 'package:golden_app/model/estimate_resource.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/model/product.dart';
import 'package:golden_app/model/provider.dart' as prov;
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/model/user.dart';

import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';

import 'package:golden_app/services/api/api.dart';

class EditEstimateScreen extends StatefulWidget {
  final Estimate editEstimate;

  EditEstimateScreen({
    @required this.editEstimate,
  });

  @override
  State<StatefulWidget> createState() => new _EditScreenState();
}

class _EditScreenState extends State<EditEstimateScreen> {
  List<EstimateItem> _estimateItem = [];
  List<OutlayCategory> _cat = [];
  List<OutlayItem> _outlayItem = [];
  List<EstimateResource> _estimateResource = [];
  List<Product> _products = [];
  List<prov.Provider> _provider = [];
  List<Resource> _resource = [];

  var formatter = NumberFormat('#,###.#');

  User user;
  DateTime created;

  getDataFromApi() {
    ApiService.getInstance().getEstimateItem().then((value) {
      value.results.forEach((element) {
        if (element.estimate == widget.editEstimate.id)
          _estimateItem.add(element);
      });
      setState(() {});
    });

    ApiService.getInstance().getEstimateResources().then((value) {
      value.results.forEach((element) {
        if (element.estimate == widget.editEstimate.id) _estimateResource.add(
            element);
      });
      setState(() {});
    });
  }

  getItemFromDb() {
    _estimateItem.clear();
    Floor.instance.database.then((db) {
      db.estimateItemDao.getAllEstimateItems().then((value) =>
          value.forEach((element) {
            if (element.estimate == widget.editEstimate.id)
              _estimateItem.add(EstimateItem.fromJson(element.toJson()));
          }));
      setState(() {});
    });
  }

  getResFromDb() {
    _estimateResource.clear();
    Floor.instance.database.then((db) {
      db.estimateResourceDao.getAllEstimateResources().then((value) =>
          value.forEach((element) {
            if (element.estimate == widget.editEstimate.id)
              _estimateResource.add(
                  EstimateResource.fromJson(element.toJson()));
          }));
      setState(() {});
    });
  }

  getDataFromDb() {
    Floor.instance.database.then((db) =>
        db.productDao.getAllProducts()
            .then((pr) =>
            pr.forEach((e) => _products.add(Product.fromJson(e.toJson()))))
            .then((value) =>
            db.providerDao.getAllProviders().then((man) =>
                man.forEach((element) =>
                    _provider.add(
                        prov.Provider.fromJson(element.toJson()))
                )).then((value) =>
                db.resourceDao.getAllResources().then((res) =>
                    res.forEach((element) =>
                        _resource.add(Resource.fromJson(element.toJson()))
                    )))).then((value) =>
            db.outlayCategoryDao.getAllOutlayCategories().then((outs) =>
                outs.forEach((e) =>
                    _cat.add(OutlayCategory.fromJson(e.toJson())))).then((
                value) =>
                db.outlayItemDao.getAllOutlayItems().then((items) =>
                    items.forEach((element) =>
                        _outlayItem.add(
                            OutlayItem.fromJson(element.toJson()))))))
    );
  }

  @override
  void initState() {
    Future.sync(() async {
      user = User.fromJson(await getUser());
      setState(() {

      });
    });
    // getUser().then((value) {
    //   setState(() {
    //     user = User.fromJson(value);
    //   });
    // });
    setState(() {
      created = DateTime.parse(widget.editEstimate.created);
      getDataFromDb();
      getDataFromApi();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return 'январь';
      case 2:
        return 'февраль';
      case 3:
        return 'март';
      case 4:
        return 'апрель';
      case 5:
        return 'май';
      case 6:
        return 'июнь';
      case 7:
        return 'июль';
      case 8:
        return 'августь';
      case 9:
        return 'сентябрь';
      case 10:
        return 'октябрь';
      case 11:
        return 'ноябрь';
      case 12:
        return 'декабрь';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    Widget requestConfirmEstimate(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16),
            left: ScreenUtil().setWidth(24),
            right: ScreenUtil().setWidth(24)),
        child: Card(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(12),
                      left: ScreenUtil().setWidth(24)),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Смета №${widget.editEstimate.docNumb} от ${created
                        .day} ${getMonth(created.month)} ${created
                        .year} г. ${created
                        .hour}:${created.minute}',
                    style: AppStyles.contentTextStyle.copyWith(
                        fontSize: ScreenUtil().setSp(24)),)),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(24),
                      bottom: ScreenUtil().setHeight(24),
                      left: ScreenUtil().setWidth(24)
                  ),
                  child: Text('Состояние: В процессе',
                      style: AppStyles.contentTextStyle.copyWith(
                          fontSize: ScreenUtil().setSp(24),
                          color: Colors.grey))),
              Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(12),
                    bottom: ScreenUtil().setHeight(8)),
                alignment: Alignment.centerRight, child: RaisedButton(
                color: AppColors.buttonColor,
                child: Text('Подтвердить',
                  style: AppStyles.buttonTextStyle.copyWith(
                      fontSize: ScreenUtil().setSp(24)),),
                onPressed: () {
                  Future.sync(() async {
                    final http.Response response = await ApiService
                        .getInstance().confirmEstimate(widget.editEstimate.id,
                        user.id);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      setState(() {
                        widget.editEstimate.directorStatus = 1;
                      });
                      var db = await Floor.instance.database;
                      db.estimateDao.insertEstimate(estDb.Estimate.fromJson(
                          widget.editEstimate.toJson()));
                    }
                  });
                },
              ),)
            ],
          ),
        ),
      );
    }

    Widget confirmedEstimate(BuildContext context) {
      DateTime directorDate = DateTime.parse(
          widget.editEstimate.directorStatusDate);
      return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
        height: ScreenUtil().setHeight(200),
        width: ScreenUtil().setWidth(700),
        child: Card(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(12),
                    left: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Смета №${widget.editEstimate.docNumb} от ${created
                        .day} ${getMonth(created.month)} ${created
                        .year} г. ${created
                        .hour}:${created.minute}'),),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(12),
                    horizontal: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft,
                child: Text('Состояние: ${widget.editEstimate.status}'),),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(12),
                    horizontal: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft, child: Text(
                  '${user.userType} Подтвердил: ${user.firstName} ${user
                      .lastName} | ${directorDate.day} ${getMonth(
                      directorDate.month)} ${directorDate
                      .year} г. ${directorDate.hour}:${directorDate.minute}'),),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменения закупки'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            user != null ? user.userType == 'admin'
                ? widget.editEstimate.directorStatus == 1 ? confirmedEstimate(
                context) : requestConfirmEstimate(context)
                : Container() : Container(),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Список сырья',
                    style: AppStyles.headerTextStyle.copyWith(
                        fontSize: ScreenUtil().setSp(28)),),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AddResourceDialog(
                                estimateId: widget.editEstimate.id,
                                provider: _provider,
                                resource: _resource,
                                onSubmitted: (int statusCode) {
                                  if (statusCode == 200)
                                    setState(() {
                                      getResFromDb();
                                    });
                                },
                              ));
                    },
                    child: Text(
                        'Добавить сырьё', style: AppStyles.buttonTextStyle),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(12),
                  horizontal: ScreenUtil().setWidth(24)),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: ScreenUtil().setWidth(24),
                    rows: _estimateResource
                        .map((e) =>
                        DataRow(
                          color: MaterialStateProperty.resolveWith<
                              Color>(
                                  (Set<MaterialState> states) {
                                // All rows will have the same selected color.
                                if (states.contains(
                                    MaterialState.selected))
                                  return Theme
                                      .of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08);
                                // Even rows will have a grey color.
                                if (e.status == 1)
                                  return Colors.deepOrange
                                      .withOpacity(
                                      0.3);
                                if (e.sendWarehouse &&
                                    e.status != 1)
                                  return Colors.orange.withOpacity(
                                      0.3);
                                return null; // Use default value for other states and odd rows.
                              }),
                          cells: [
                            DataCell(Text(_resource
                                .singleWhere((res) =>
                            res.id == e.resource)
                                .title)),
                            DataCell(Text(formatter.format(e.count))),
                            DataCell(Text(formatter.format(e.price))),
                            DataCell(Text(formatter.format(e.amount))),
                            DataCell(Text(_provider
                                .singleWhere((element) =>
                            element.id == e.provider, orElse: () =>
                                prov.Provider(name: 'null'))
                                .name)),
                            DataCell(e.status != 1
                                ? PopupMenuButton(
                                onSelected: (String value) {
                                  if (value == 'change') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ChangeCount(item: e,
                                            type: 'estimateResource',
                                            onSubmit: (int statusCode) {
                                              if (statusCode == 200) {
                                                setState(() {
                                                  getDataFromDb();
                                                });
                                              }
                                            },),);
                                  }
                                  if (value == 'cancel') {
                                    setState(() {
                                      e.status = 1;
                                    });
                                  }
                                  if (value == 'income') {
                                    setState(() {
                                      e.sendWarehouse = true;
                                      ApiService.getInstance()
                                          .sendWarehouse(e);
                                    });
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  if (e.sendWarehouse &&
                                      e.status == 0) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'change',
                                        child: Text(
                                            'Изменить количество'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'cancel',
                                        child: Text('Отменить'),
                                      ),
                                    ];
                                  } else if (!e.sendWarehouse &&
                                      e.status == 0) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'change',
                                        child: Text(
                                            'Изменить количество'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'cancel',
                                        child: Text('Отменить'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'income',
                                        child: Text(
                                            'Приход в склад'),
                                      ),
                                    ];
                                  }
                                  return null;
                                })
                                : Container()),
                          ],
                        ))
                        .toList(),
                    columns: [
                      DataColumn(label: Text('Название')),
                      DataColumn(label: Text('Кол-во')),
                      DataColumn(label: Text('Цена за ед.')),
                      DataColumn(label: Text('Итог')),
                      DataColumn(label: Text('Поставщик')),
                      DataColumn(label: Text('Действие')),
                    ],
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Список расходов',
                    style: AppStyles.headerTextStyle.copyWith(
                        fontSize: ScreenUtil().setSp(28)),),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    child:
                    Text('Добавить расход', style: AppStyles.buttonTextStyle),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AddOutlayDialog(
                                estimateId: widget.editEstimate.id,
                                outlayCategory: _cat,
                                provider: _provider,
                                outlayItems: _outlayItem,
                                onSubmitted: (int statusCode) {
                                  if (statusCode == 200)
                                    setState(() {
                                      getItemFromDb();
                                    });
                                },));
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(12),
                  horizontal: ScreenUtil().setWidth(24)),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: ScreenUtil().setWidth(32),
                    columns: [
                      DataColumn(label: Text('Категория')),
                      DataColumn(label: Text('Название')),
                      DataColumn(label: Text('Кол-во')),
                      DataColumn(label: Text('Цена за ед.')),
                      DataColumn(label: Text('Итог')),
                      DataColumn(label: Text('Поставщик')),
                      DataColumn(label: Text('Действие')),
                    ],
                    rows: _estimateItem
                        .map((e) =>
                        DataRow(
                            cells: [
                              DataCell(
                                  Text(_cat.singleWhere((element) {
                                    var category = _outlayItem
                                        .singleWhere((outs) =>
                                    outs.id == e.outlayItem)
                                        .outlayCategory;
                                    return element.id == category;
                                  }).title)),
                              DataCell(Text(
                                  _outlayItem
                                      .singleWhere((element) =>
                                  element.id == e.outlayItem)
                                      .title)),
                              DataCell(Text(formatter.format(e.count))),
                              DataCell(Text(formatter.format(e.price))),
                              DataCell(Text(formatter.format(e.amount))),
                              DataCell(Text(_provider
                                  .singleWhere((element) =>
                              element.id == e.provider,
                                  orElse: () =>
                                      prov.Provider(name: 'null'))
                                  .name)),
                              DataCell(
                                  e.status != 1
                                      ? PopupMenuButton(
                                      onSelected: (String value) {
                                        if (value == 'change') {
                                          showDialog(

                                            context: context,
                                            builder: (BuildContext context) =>
                                                ChangeCount(
                                                  item: e,
                                                  type: 'estimateItem',
                                                  onSubmit: (int statusCode) {
                                                    if (statusCode == 200) {
                                                      setState(() {
                                                        getDataFromDb();
                                                      });
                                                    }
                                                  },),);
                                        }
                                        if (value == 'cancel') {
                                          setState(() {
                                            e.status = 1;
                                          });
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        if (e.status == 0) {
                                          return <PopupMenuEntry<String>>[
                                            const PopupMenuItem<
                                                String>(
                                              value: 'change',
                                              child: Text(
                                                  'Изменить количество'),
                                            ),
                                            const PopupMenuItem<
                                                String>(
                                              value: 'cancel',
                                              child: Text(
                                                  'Отменить'),
                                            ),
                                          ];
                                        }
                                        return null;
                                      })
                                      : Container()),
                            ]))
                        .toList(),
                  )
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(64)),
          ],
        ),
      ),
    );
  }
}
