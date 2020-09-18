import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/component/dialog/add_outlay_item.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/outlay_item.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/component/dialog/edit_oulay_item.dart';
import 'package:golden_app/services/api/api.dart';

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
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(24)),
              child: Row(
                children: [
                  Expanded(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          '№',
                          style: AppStyles.headerTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(22)),
                        )),
                        DataColumn(
                          label: Text(
                            'Навзвание категории',
                            style: AppStyles.headerTextStyle
                                .copyWith(fontSize: ScreenUtil().setSp(22)),
                          ),
                        )
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(widget.outlay.id.toString(),
                              style: AppStyles.contentTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(22)))),
                          DataCell(
                            Text(widget.outlay.title,
                                style: AppStyles.contentTextStyle.copyWith(
                                    fontSize: ScreenUtil().setSp(22))),
                          )
                        ])
                      ],
                    ),
                  ),
                ],
              ),
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
                      'Добавить расходы',
                      style: AppStyles.buttonTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(20)),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddOutlayItem());
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              alignment: Alignment.centerLeft,
              child: Text(
                'Расходы',
                style: AppStyles.headerTextStyle
                    .copyWith(fontSize: ScreenUtil().setSp(30)),
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
                                      ApiService.getInstance()
                                          .deleteOutlayItem(e.id);
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
