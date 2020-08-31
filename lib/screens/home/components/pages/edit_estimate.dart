import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/models/estimate_item.dart';
import 'package:golden_app/models/estimate_resource.dart';
import 'package:golden_app/models/manufacture.dart';
import 'package:golden_app/models/outlay_category.dart';
import 'package:golden_app/models/outlay_item.dart';
import 'package:golden_app/models/product.dart';
import 'package:golden_app/models/resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/home/components/dialogs/add_outlay.dart';
import 'package:golden_app/screens/home/components/dialogs/add_resource.dart';
import 'package:golden_app/screens/home/components/dialogs/change_count.dart';
import 'package:golden_app/services/api/api.dart';

class EditEstimateScreen extends StatefulWidget {
  final Estimate editEstimate;

  EditEstimateScreen({
    @required this.editEstimate,
  });

  @override
  State<StatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditEstimateScreen> {
  List<EstimateItem> _estimateItem = [];
  List<OutlayCategory> _cat = [];
  List<OutlayItem> _outlayItem = [];
  List<EstimateResource> _estimateResource = [];
  List<Product> _products = [];
  List<Manufacture> _manufactures = [];
  List<Resource> _resource = [];

  @override
  void initState() {
    super.initState();
    Floor.instance.database.then((db) =>
        db.estimateResourceDao
            .getAllEstimateResources()
            .then((esRes) =>
            esRes.forEach(
                    (e) {
                  if (e.estimate == widget.editEstimate.id)
                    _estimateResource.add(
                        EstimateResource.fromJson(e.toJson()));
                }))
            .then((value) =>
            db.productDao
                .getAllProducts()
                .then((pr) =>
                pr.forEach((e) => _products.add(Product.fromJson(e.toJson()))))
                .then((value) =>
                db.manufactureDao.getAllManufactures().then((man) =>
                    man.forEach((element) =>
                        _manufactures.add(
                            Manufacture.fromJson(element.toJson()))
                    )).then((value) =>
                    db.resourceDao.getAllResources().then((res) =>
                        res.forEach((element) =>
                            _resource.add(Resource.fromJson(element.toJson()))
                        ))))));
    final _api = ApiService.getInstance();
    _api.getOutlayItem().then((value) =>
        value.results.forEach((element) => _outlayItem.add(element)));
    _api.getEstimateItem().then((value) =>
        value.results.forEach((element) {
          if (element.estimate == widget.editEstimate.id)
            _estimateItem.add(element);
        }));
    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменения закупки'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                color: AppColors.buttonColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AddResourceDialog(
                            estimateId: widget.editEstimate.id,
                            manufactures: _manufactures,
                            products: _products,
                          ));
                },
                child: Text('Добавить сырьё', style: AppStyles.buttonTextStyle),
              ),
            ),
            Container(
              child: DataTable(
                columnSpacing: ScreenUtil().setWidth(32),
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
                        DataCell(Text(e.count.toString())),
                        DataCell(Text(e.price.toString())),
                        DataCell(Text(e.amount.toString())),
                        DataCell(Text(e.provider.toString())),
                        DataCell(e.status != 1
                            ? PopupMenuButton(onSelected: (String value) {
                          if (value == 'change') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ChangeCount(e));
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
                        }, itemBuilder: (BuildContext context) {
                          if (e.sendWarehouse && e.status == 0) {
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
                          } else if (!e.sendWarehouse &&
                              e.status == 0) {
                            return <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'change',
                                child: Text('Изменить количество'),
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                color: AppColors.buttonColor,
                child:
                Text('Добавить Outlay', style: AppStyles.buttonTextStyle),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AddOutlayDialog(

                          ));
                },
              ),
            ),
            Container(
              child: DataTable(
                columnSpacing: ScreenUtil().setWidth(32),
                rows: _estimateItem
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
                              else if (e.status != 1)
                                return Colors.orange.withOpacity(0.3);
                              return null; // Use default value for other states and odd rows.
                            }),
                        cells: [
                          DataCell(Text(e.id.toString())),
                          DataCell(Text(e.company.toString())),
                          DataCell(Text(e.count.toString())),
                          DataCell(Text(e.price.toString())),
                          DataCell(Text(e.amount.toString())),
                          DataCell(Text(e.provider.toString())),
                          DataCell(
                              e.status != 1
                                  ? PopupMenuButton(onSelected: (String value) {
                                if (value == 'change') {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ChangeCount(e));
                                }
                                if (value == 'cancel') {
                                  setState(() {
                                    e.status = 1;
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
                columns: [
                  DataColumn(label: Text('Категория')),
                  DataColumn(label: Text('Название')),
                  DataColumn(label: Text('Кол-во')),
                  DataColumn(label: Text('Цена за ед.')),
                  DataColumn(label: Text('Итог')),
                  DataColumn(label: Text('Поставщик')),
                  DataColumn(label: Text('Действие')),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(64)),
          ],
        ),
      ),
    );
  }
}
