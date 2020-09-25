import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/outlay/components/add_outlay.dart';
import 'package:golden_app/screens/outlay/components/edit_outlay.dart';
import 'package:golden_app/screens/outlay/components/show_outlay.dart';

class OutlayPage extends StatefulWidget {
  static const route = '/outlay';

  @override
  State<StatefulWidget> createState() => new _OutlayPageState();
}

class _OutlayPageState extends State<OutlayPage> {
  List<OutlayCategory> outlayResponse = [];

  getOutlay() {
    List<OutlayCategory> category = [];
    Floor.instance.database.then((db) async {
      await db.outlayCategoryDao.getAllOutlayCategories().then((value) =>
          value.forEach((element) =>
              category.add(OutlayCategory.fromJson(element.toJson()))));
      setState(() => outlayResponse = category);
    });
  }

  @override
  void initState() {
    getOutlay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('Категория расхода'),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setWidth(24),
                    top: ScreenUtil().setHeight(24)),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text('Список категорий расходов',
                            style: AppStyles.headerTextStyle
                                .copyWith(fontSize: ScreenUtil().setSp(32)))),
                    RaisedButton(
                      color: AppColors.buttonColor,
                      splashColor: Colors.blue,
                      textColor: Colors.white,
                      child: Text(
                        'Добавить',
                        style: AppStyles.buttonTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddOutlayPage(
                                  onSubmitted: (int statusCode) {
                                    if (statusCode == 200 ||
                                        statusCode == 201) {
                                      getOutlay();
                                    }
                                  },
                                ),
                            fullscreenDialog: true));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(24),
                    horizontal: ScreenUtil().setWidth(16)),
                child: Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columnSpacing: 0,
                        columns: [
                          DataColumn(
                              label: Text(
                            '№',
                            style: AppStyles.tableTextStyle
                                .copyWith(fontSize: ScreenUtil().setSp(20)),
                          )),
                          DataColumn(
                              label: Text(
                            'Название',
                            style: AppStyles.tableTextStyle
                                .copyWith(fontSize: ScreenUtil().setSp(20)),
                          )),
                          DataColumn(
                              label: Text(
                            'Действие',
                            style: AppStyles.tableTextStyle
                                .copyWith(fontSize: ScreenUtil().setSp(20)),
                          )),
                        ],
                        rows: outlayResponse
                            .map(
                              (e) => DataRow(cells: [
                                DataCell(Text(
                                  (e.id ?? e.id).toString(),
                                  style: AppStyles.tableTextStyle.copyWith(
                                      fontSize: ScreenUtil().setSp(20)),
                                )),
                                DataCell(Text(
                                  (e.title ?? e.title),
                                  style: AppStyles.tableTextStyle.copyWith(
                                      fontSize: ScreenUtil().setSp(20)),
                                )),
                                DataCell(
                                  PopupMenuButton(
                                    onSelected: (String value) {
                                      if (value == 'change') {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditOutlayPage(
                                                      outlay: e,
                                                      onSubmit:
                                                          (int statusCode) {
                                                        if (statusCode == 200 ||
                                                            statusCode == 201) {
                                                          setState(() =>
                                                              getOutlay());
                                                        }
                                                      },
                                                    )));
                                        return null;
                                      }
                                      if (value == 'look') {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowOutlayPage(
                                                      outlay: e,
                                                    )));
                                      }
                                      return null;
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'look',
                                        child: Text('Посмотреть'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'change',
                                        child: Text('Изменить'),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
