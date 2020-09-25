import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:golden_app/component/dialog/add_estimate_item.dart';
import 'package:golden_app/component/dialog/add_estimate_resource.dart';
import 'package:golden_app/component/dialog/change_count.dart';

import 'package:golden_app/common/function/get_user.dart';

import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate.dart' as estDb;
import 'package:golden_app/data/db/model/estimate_resource.dart' as estResDb;
import 'package:golden_app/data/db/model/estimate_item.dart' as estItemDb;

import 'package:golden_app/model/estimate.dart';
import 'package:golden_app/model/estimate_item.dart';
import 'package:golden_app/model/estimate_resource.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/model/product.dart';
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/model/user.dart';

import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';

import 'package:golden_app/services/api.dart';

class EditEstimateScreen extends StatefulWidget {
  final Estimate editEstimate;
  final Function(bool inserted) onSubmit;

  EditEstimateScreen({@required this.editEstimate, this.onSubmit});

  @override
  State<StatefulWidget> createState() => new _EditScreenState();
}

class _EditScreenState extends State<EditEstimateScreen> {
  List<EstimateItem> _estimateItem = [];
  List<OutlayCategory> _cat = [];
  List<OutlayItem> _outlayItem = [];
  List<EstimateResource> _estimateResource = [];
  List<Product> _products = [];
  List<Provider> _provider = [];
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
                        Provider.fromJson(element.toJson()))
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

  // getEstResFromApi() async {
  //   await ApiService.getInstance().getEstimateResources().then((api) {
  //     api.results.forEach((e) {
  //       if (e.estimate == widget.editEstimate.id)
  //         _estimateResource.add(e);
  //     });
  //     setState(() {});
  //   });
  // }
  //
  // getEstItemFromApi() async {
  //   await ApiService.getInstance().getEstimateItem().then((api) {
  //     api.results.forEach((e) {
  //       if (e.estimate == widget.editEstimate.id)
  //         _estimateItem.add(e);
  //     });
  //     setState(() {});
  //   });
  // }
  //
  // getDataFromApi() {
  //   getEstResFromApi();
  //   getEstItemFromApi();
  // }
  //
  // getEstItemFromDb() {
  //   _estimateItem.clear();
  //   Floor.instance.database.then((db) {
  //     db.estimateItemDao
  //         .getAllEstimateItems()
  //         .then((value) => value.forEach((element) {
  //               if (element.estimate == widget.editEstimate.id)
  //                 _estimateItem.add(EstimateItem.fromJson(element.toJson()));
  //             }));
  //     setState(() {});
  //   });
  // }
  //
  // getEstResFromDb() {
  //   _estimateResource.clear();
  //   Floor.instance.database.then((db) {
  //     db.estimateResourceDao
  //         .getAllEstimateResources()
  //         .then((value) => value.forEach((element) {
  //               if (element.estimate == widget.editEstimate.id)
  //                 _estimateResource
  //                     .add(EstimateResource.fromJson(element.toJson()));
  //             }));
  //     setState(() {});
  //   });
  // }
  //
  // getProductsFromDb() {
  //   _products.clear();
  //   Floor.instance.database.then((db) {
  //     db.productDao.getAllProducts().then((pr) =>
  //         pr.forEach((e) => _products.add(Product.fromJson(e.toJson()))));
  //     setState(() {});
  //   });
  // }
  //
  // getProvidersFromDb() {
  //   _provider.clear();
  //   Floor.instance.database.then((db) {
  //     db.providerDao.getAllProviders().then((man) => man.forEach((element) =>
  //         _provider.add(prov.Provider.fromJson(element.toJson()))));
  //     setState(() {});
  //   });
  // }
  //
  // getResourcesFromDb() {
  //   _resource.clear();
  //   Floor.instance.database
  //       .then((db) => db.resourceDao.getAllResources().then((res) {
  //             res.forEach((e) => _resource.add(Resource.fromJson(e.toJson())));
  //             setState(() {});
  //           }));
  // }
  //
  // getOutlayCategoryFromDb() {
  //   _cat.clear();
  //   Floor.instance.database.then((db) {
  //     db.outlayCategoryDao.getAllOutlayCategories().then((outs) =>
  //         outs.forEach((e) => _cat.add(OutlayCategory.fromJson(e.toJson()))));
  //     setState(() {});
  //   });
  // }
  //
  // getOutlayItemFromDb() {
  //   _outlayItem.clear();
  //   Floor.instance.database.then((db) {
  //     db.outlayItemDao.getAllOutlayItems().then((items) => items.forEach(
  //         (element) => _outlayItem.add(OutlayItem.fromJson(element.toJson()))));
  //     setState(() {});
  //   });
  // }
  //
  // getDataFromDb() {
  //   setState(() {
  //     getProductsFromDb();
  //     getResourcesFromDb();
  //     getProvidersFromDb();
  //     getOutlayCategoryFromDb();
  //     getOutlayItemFromDb();
  //     getEstItemFromDb();
  //     getEstResFromDb();
  //   });
  // }

  @override
  void initState() {
    Future.sync(() async => user = User.fromJson(await getUser()));
    // setState(() {
    //   created = DateTime.parse(widget.editEstimate.created);
    //   getDataFromDb();
    //   // getDataFromApi();
    // });
    setState(() {
      created = DateTime.parse(widget.editEstimate.created);
      getDataFromDb();
      getDataFromApi();
    });
    super.initState();
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

  String getStatus(int status) {
    switch (status) {
      case 1:
        return 'Открыто';
      case 2:
        return 'В процессе';
      case 3:
        return 'Закрыто';
    }
    return '';
  }

  String getUserType(String type) {
    switch (type) {
      case 'admin':
        return 'Директор';
      case 'accountant':
        return 'Бухгалтер';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    Widget requestConfirmEstimate(BuildContext context) =>
        Container(
          // height: ScreenUtil().setHeight(250),
          width: ScreenUtil().setWidth(700),
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(16),
              horizontal: ScreenUtil().setWidth(24)),
          child: Card(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(12),
                        horizontal: ScreenUtil().setWidth(24)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Смета №${widget.editEstimate.docNumb} от ${created
                          .day} ${getMonth(created.month)} ${created
                          .year} г. ${created.hour}:${created.minute}',
                      style: AppStyles.contentTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(12),
                        horizontal: ScreenUtil().setWidth(24)),
                    child: Text(
                        'Состояние: ${getStatus(widget.editEstimate.status)}',
                        style: AppStyles.contentTextStyle.copyWith(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.grey))),
                Container(
                  margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(24),
                      bottom: ScreenUtil().setHeight(12)),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    color: AppColors.buttonColor,
                    child: Text(
                      'Подтвердить',
                      style: AppStyles.buttonTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                    onPressed: () {
                      Future.sync(() async {
                        var db = await Floor.instance.database;
                        final response = await ApiService.getInstance()
                            .confirmEstimate(widget.editEstimate.id, user.id);
                        print(response.body);
                        if (response.statusCode == 200) {
                          var tempEstimate = widget.editEstimate;
                          tempEstimate.directorStatus = 1;
                          tempEstimate.directorStatusDate =
                              DateTime.now().toIso8601String();
                          tempEstimate.directorUser = user.id;
                          var index = await db.estimateDao.insertEstimate(
                              estDb.Estimate.fromJson(tempEstimate.toJson()));
                          print(index);
                          widget.onSubmit(index != null ? true : false);
                          // await db.estimateDao.getEstimate(widget.editEstimate.id)
                          //     .then((value) => print(value.toJson()));
                          setState(() {
                            widget.editEstimate.directorStatus = 1;
                            widget.editEstimate.directorStatusDate =
                                DateTime.now().toIso8601String();
                            widget.editEstimate.directorUser = user.id;
                          });
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );

    Widget confirmedEstimate(BuildContext context) {
      DateTime directorDate =
      DateTime.tryParse(widget.editEstimate.directorStatusDate);

      DateTime counterDate = DateTime.tryParse(
          widget.editEstimate.counterStatusDate != null
              ? widget.editEstimate.counterStatusDate
              : '2020-09-09');

      return Container(
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(16),
            horizontal: ScreenUtil().setWidth(24)),
        // height: ScreenUtil().setHeight(250),
        width: ScreenUtil.screenWidth,
        child: Card(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(12),
                    horizontal: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Смета №${widget.editEstimate.docNumb} от ${created
                        .day} ${getMonth(created.month)} ${created
                        .year} г. ${created.hour}:${created.minute}'),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(12),
                      horizontal: ScreenUtil().setWidth(24)),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Состояние: ${getStatus(widget.editEstimate.status)}',
                    style: AppStyles.contentTextStyle.copyWith(
                        fontSize: ScreenUtil().setSp(24),
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(12),
                    horizontal: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(
                  style: TextStyle(fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(24),
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: '${getUserType(user.userType)}',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(24))),
                    TextSpan(text: ' '),
                    TextSpan(text: 'подтвердил:'),
                    TextSpan(text: ' '),
                    TextSpan(text: '${user.firstName} ${user.lastName}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(24),
                            fontWeight: FontWeight.w800)),
                    TextSpan(text: ' \n '),
                    TextSpan(text: '${directorDate.day} ${getMonth(
                        directorDate.month)} ${directorDate
                        .year} г. ${directorDate.hour}:${directorDate.minute <
                        10 ? '0${directorDate.minute}' : '${directorDate
                        .minute}'}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(24),
                            color: Colors.black)),
                  ],
                ),),
              ),
              widget.editEstimate.counterStatus == 0? Container() : Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(12),
                    bottom: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setWidth(24)),
                alignment: Alignment.centerLeft,
                child:
                    widget.editEstimate.counterStatus == 1
                    ? RichText(text: TextSpan(
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(text: 'Бухгалтер',style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: ' '),
                      TextSpan(text: 'подтвердил:'),
                      TextSpan(text: ' '),
                      TextSpan(text: '${counterDate.day} ${getMonth(
                          counterDate.month)} ${counterDate
                          .year} г. ${counterDate
                          .hour}:${counterDate.minute < 10 ? '0${counterDate
                          .minute}' : '${counterDate.minute}'}'),
                    ]))
                    : Text(''),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменения закупки'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            user != null
                ? user.userType == 'admin'
                ? widget.editEstimate.directorStatus == 1
                ? confirmedEstimate(context)
                : requestConfirmEstimate(context)
                : Container()
                : Container(),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Список сырья',
                    style: AppStyles.headerTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(28)),
                  ),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    onPressed: () {
                      showDialog(
                          useSafeArea: true,
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                                child: AddResourceDialog(
                                  estimateId: widget.editEstimate.id,
                                  provider: _provider,
                                  resource: _resource,
                                  onSubmitted: (int statusCode) {
                                    if (statusCode == 200)
                                      setState(() => getDataFromDb());
                                  },
                                ),
                              ));
                    },
                    child: Text('Добавить сырьё',
                        style: AppStyles.buttonTextStyle),
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
                          color: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                // All rows will have the same selected color.
                                if (states.contains(MaterialState.selected))
                                  return Theme
                                      .of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08);
                                // Even rows will have a grey color.
                                if (e.status == 1)
                                  return Colors.deepOrange.withOpacity(0.3);
                                if (e.sendWarehouse && e.status != 1)
                                  return Colors.orange.withOpacity(0.3);
                                return null; // Use default value for other states and odd rows.
                              }),
                          cells: [
                            DataCell(Text(_resource
                                .singleWhere((res) => res.id == e.resource)
                                .title)),
                            DataCell(Text(formatter.format(e.count))),
                            DataCell(Text(formatter.format(e.price))),
                            DataCell(Text(formatter.format(e.amount))),
                            DataCell(Text(_provider
                                .singleWhere(
                                    (element) => element.id == e.provider,
                                orElse: () => Provider(name: ''))
                                .name)),
                            DataCell(e.status != 1
                                ? PopupMenuButton(
                                onSelected: (String value) {
                                  if (value == 'change') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ChangeCount(
                                            item: e,
                                            type: 'estimateResource',
                                            onSubmit: (int statusCode) {
                                              if (statusCode == 200) {
                                                setState(() {
                                                  getDataFromDb();
                                                });
                                              }
                                            },
                                          ),
                                    );
                                  }
                                  if (value == 'cancel') {
                                    Future.sync(() async {
                                      setState(() => e.status = 1);
                                      final response = await ApiService
                                          .getInstance().cancelEstimateResource(
                                          e);
                                      if (response.statusCode == 200) {
                                        Floor.instance.database.then((db) =>
                                            db.estimateResourceDao
                                                .insertEstimateResource(
                                                estResDb.EstimateResource
                                                    .fromJson(e.toJson())));
                                      }
                                    });
                                  }
                                  if (value == 'income') {
                                    Future.sync(() async {
                                      final response =
                                      await ApiService.getInstance()
                                          .sendWarehouse(e, user);
                                      if (response.statusCode == 200)
                                        setState(() => e.sendWarehouse = true);
                                    });
                                  }
                                }, itemBuilder: (BuildContext context) {
                              if (e.sendWarehouse && e.status == 0) {
                                return <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'change',
                                    child:
                                    Text('Изменить количество'),
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
                                    child:
                                    Text('Изменить количество'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'cancel',
                                    child: Text('Отменить'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'income',
                                    child: Text('Приход в склад'),
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
                  )),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Список расходов',
                    style: AppStyles.headerTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(28)),
                  ),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    child: Text('Добавить расход',
                        style: AppStyles.buttonTextStyle),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                                child: AddOutlayDialog(
                                  estimateId: widget.editEstimate.id,
                                  outlayCategory: _cat,
                                  provider: _provider,
                                  outlayItems: _outlayItem,
                                  onSubmitted: (int statusCode) {
                                    if (statusCode == 200)
                                      setState(() {
                                        getDataFromDb();
                                      });
                                  },
                                ),
                              ));
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
                        DataRow(cells: [
                          DataCell(Text(_cat.singleWhere((element) {
                            var category = _outlayItem
                                .singleWhere(
                                    (outs) => outs.id == e.outlayItem)
                                .outlayCategory;
                            return element.id == category;
                          }).title)),
                          DataCell(Text(_outlayItem
                              .singleWhere(
                                  (element) => element.id == e.outlayItem)
                              .title)),
                          DataCell(Text(formatter.format(e.count))),
                          DataCell(Text(formatter.format(e.price))),
                          DataCell(Text(formatter.format(e.amount))),
                          DataCell(Text(_provider
                              .singleWhere(
                                  (element) => element.id == e.provider,
                              orElse: () => Provider(name: ''))
                              .name)),
                          DataCell(e.status != 1
                              ? PopupMenuButton(onSelected: (String value) {
                            if (value == 'change') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ChangeCount(
                                      item: e,
                                      type: 'estimateItem',
                                      onSubmit: (int statusCode) {
                                        if (statusCode == 200) {
                                          setState(() => getDataFromDb());
                                        }
                                      },
                                    ),
                              );
                            }
                            if (value == 'cancel') {
                              Future.sync(() async {
                                setState(() => e.status = 1);
                                final response = await ApiService.getInstance()
                                    .cancelEstimateItem(e);
                                if (response.statusCode == 200) {
                                  Floor.instance.database.then((db) =>
                                      db.estimateItemDao.insertEstimateItem(
                                          estItemDb.EstimateItem.fromJson(
                                              e.toJson())));
                                }
                              });
                            }
                          }, itemBuilder: (BuildContext context) {
                            if (e.status == 0) {
                              return <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'change',
                                  child: Text('Изменить количество'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'cancel',
                                  child: Text('Отменить'),
                                ),
                              ];
                            }
                            return null;
                          })
                              : Container()),
                        ]))
                        .toList(),
                  )),
            ),
            SizedBox(height: ScreenUtil().setHeight(64)),
          ],
        ),
      ),
    );
  }
}
