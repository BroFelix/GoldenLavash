import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/resource/components/add_resource.dart';
import 'package:golden_app/screens/resource/components/edit_resource.dart';

class ResourceKitchenPage extends StatefulWidget {
  static const route = '/resource_kitchen';

  @override
  State<StatefulWidget> createState() => new _ResourceKitchenPageState();
}

class _ResourceKitchenPageState extends State<ResourceKitchenPage> {
  List<Resource> resources = [];

  getResources() {
    List<Resource> resource = [];
    Floor.instance.database.then((db) async {
      await db.resourceDao
          .getAllResources()
          .then((value) => value.forEach((element) {
                if (element.resourceType == 'kitchen')
                  resource.add(Resource.fromJson(element.toJson()));
              }));
      setState(() => resources = resource);
    });
  }

  @override
  void initState() {
    getResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('Сырьё кухня'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(32),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Список сырья в кухне',
                    style: AppStyles.headerTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(28)),
                  ),
                  RaisedButton(
                    color: AppColors.buttonColor,
                    splashColor: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddResourcePage(onSubmit: (int statusCode) {
                                if (statusCode == 200 || statusCode == 201) {
                                  setState(() => getResources());
                                }
                              }),
                          fullscreenDialog: true));
                    },
                    child: Text(
                      'Добавить',
                      style: AppStyles.buttonTextStyle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(24),
                  horizontal: ScreenUtil().setWidth(20)),
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
                          'Тип сырья',
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
                      rows: resources
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(Text(
                                (e.id ?? e.id).toString(),
                                style: AppStyles.tableTextStyle
                                    .copyWith(fontSize: ScreenUtil().setSp(20)),
                              )),
                              DataCell(Text(
                                (e.title ?? e.title),
                                style: AppStyles.tableTextStyle
                                    .copyWith(fontSize: ScreenUtil().setSp(20)),
                              )),
                              DataCell(Text(
                                e.resourceType == 'kitchen'
                                    ? 'Кухня'
                                    : e.resourceType,
                                style: AppStyles.tableTextStyle
                                    .copyWith(fontSize: ScreenUtil().setSp(20)),
                              )),
                              DataCell(
                                PopupMenuButton(
                                  onSelected: (String value) {
                                    if (value == 'change') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditResourcePage(
                                            resource: e,
                                            onSubmit: (int statusCode) {
                                              if (statusCode == 200) {
                                                setState(() => getResources());
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
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
          ],
        ),
      ),
    );
  }
}
