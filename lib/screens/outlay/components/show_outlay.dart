import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/component/dialog/add_outlay_item.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/component/dialog/edit_oulay_item.dart';
import 'package:golden_app/services/api.dart';

class ShowOutlayPage extends StatefulWidget {
  final outlay;

  ShowOutlayPage({@required this.outlay});

  @override
  State<StatefulWidget> createState() => _ShowOutlayState();
}

class _ShowOutlayState extends State<ShowOutlayPage> {
  List<OutlayItem> outlayItem = [];

  @override
  void initState() {
    getOutlayItems();
    super.initState();
  }

  getOutlayItems() {
    List<OutlayItem> outlays = [];
    Floor.instance.database.then((db) async {
      await db.outlayItemDao.getOutlaysByCategory(widget.outlay.id).then(
          (value) => value.forEach(
              (element) => outlays.add(OutlayItem.fromJson(element.toJson()))));
      setState(() => outlayItem = outlays);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Посмотреть расход'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(48),
                  vertical: ScreenUtil().setHeight(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Категория: ',
                    style: AppStyles.headerTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(24)),
                  ),
                  Text(widget.outlay.title,
                      style: AppStyles.contentTextStyle.copyWith(
                          fontSize: ScreenUtil().setSp(24),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Список расходов',
                      style: AppStyles.headerTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(32))),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Добавить расход',
                      style: AppStyles.buttonTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(20)),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddOutlayItem(
                                category: widget.outlay,
                                onSubmit: (int statusCode) {
                                  if (statusCode == 200 || statusCode == 201) {
                                    getOutlayItems();
                                  }
                                },
                              ));
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
              child: Row(
                children: [
                  Expanded(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('Название',
                                style: AppStyles.headerTextStyle.copyWith(
                                    fontSize: ScreenUtil().setSp(22)))),
                        DataColumn(label: Container()),
                      ],
                      rows: outlayItem
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.title,
                                    style: AppStyles.contentTextStyle.copyWith(
                                        fontSize: ScreenUtil().setSp(22)))),
                                DataCell(PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'change') {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditOutlayItemDialog(
                                                item: e,
                                              ));
                                      return null;
                                    }
                                    if (value == 'delete') {
                                      Future.sync(() async {
                                        final response =
                                            await ApiService.getInstance()
                                                .deleteOutlayItem(e.id);
                                        if (response.statusCode == 200 ||
                                            response.statusCode == 204 ||
                                            response.statusCode == 404) {
                                          var db =
                                              await Floor.instance.database;
                                          print((await db.outlayItemDao
                                                  .getAllOutlayItems())
                                              .length);
                                          await db.database.delete('OutlayItem',
                                              where: 'id = ${e.id}');
                                          print((await db.outlayItemDao
                                                  .getAllOutlayItems())
                                              .length);
                                          getOutlayItems();
                                        }
                                      });
                                      return null;
                                    }
                                    return null;
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    const PopupMenuItem(
                                      child: Text('Изменить'),
                                      value: 'change',
                                    ),
                                    const PopupMenuItem(
                                      child: Text('Удалить'),
                                      value: 'delete',
                                    ),
                                  ],
                                ))
                              ]))
                          .toList(),
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
