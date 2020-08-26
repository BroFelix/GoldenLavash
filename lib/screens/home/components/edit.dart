import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/expense.dart';
import 'package:golden_app/models/resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/home/components/add_outlay.dart';
import 'package:golden_app/screens/home/components/add_resource.dart';
import 'package:golden_app/services/api/api.dart';

class EditScreen extends StatefulWidget {
  final indexOfEdit;
  final typeOfEdit;

  EditScreen({@required this.indexOfEdit, @required this.typeOfEdit});

  @override
  State<StatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<Expense> _expense = [];
  List<Resource> _resource = [];

  @override
  void initState() {
    super.initState();
    final _api = ApiService.getInstance();
    _api.getResources().then((value) => value.results.forEach((element) {
          _resource.add(element);
        }));
    _api.getExpenses().then((value) => value.results.forEach((element) {
          _expense.add(element);
        }));
    _resource.removeWhere((element) => element.estimate != widget.indexOfEdit);
    _expense.removeWhere((element) => element.estimate != widget.indexOfEdit);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменения закупки'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    top: ScreenUtil().setHeight(24)),
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  color: AppColors.buttonColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AddResourceDialog());
                  },
                  child:
                      Text('Добавить сырьё', style: AppStyles.buttonTextStyle),
                ),
              ),
              Container(
                child: DataTable(
                  columnSpacing: ScreenUtil().setWidth(32),
                  rows: _resource
                      .map((e) => DataRow(
                            cells: [
                              DataCell(Text(e.resource.toString())),
                              DataCell(Text(e.count.toString())),
                              DataCell(Text(e.price.toString())),
                              DataCell(Text(e.amount.toString())),
                              DataCell(Text(e.provider.toString())),
                              DataCell(
                                PopupMenuButton(
                                  onSelected: (String value) {
                                    if (value == 'change') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EditScreen(
                                                    indexOfEdit: e.id,
                                                    typeOfEdit: 'estimate',
                                                  ),
                                              fullscreenDialog: true));
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'change',
                                      child: Text('Изменить количество'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'cancel',
                                      child: Text('Отменить'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'income_warehouse',
                                      child: Text('Приход в склад'),
                                    ),
                                  ],
                                ),
                              ),
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
                        builder: (BuildContext context) => AddOutlayDialog());
                  },
                ),
              ),
              Container(
                child: DataTable(
                  columnSpacing: ScreenUtil().setWidth(32),
                  rows: _expense
                      .map((e) => DataRow(cells: [
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.company.toString())),
                            DataCell(Text(e.count.toString())),
                            DataCell(Text(e.price.toString())),
                            DataCell(Text(e.amount.toString())),
                            DataCell(Text(e.provider.toString())),
                            DataCell(
                              PopupMenuButton(
                                onSelected: (String value) {
                                  if (value == 'change') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditScreen(
                                                  indexOfEdit: e.id,
                                                  typeOfEdit: 'estimate',
                                                ),
                                            fullscreenDialog: true));
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'change',
                                    child: Text('Изменить количество'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'cancel',
                                    child: Text('Отменить'),
                                  ),
                                ],
                              ),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
