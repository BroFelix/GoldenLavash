import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/provider.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/provider/components/add_provider.dart';
import 'package:golden_app/screens/provider/components/edit_provider.dart';

class ProviderPage extends StatefulWidget {
  static const route = '/provider';

  @override
  State<StatefulWidget> createState() => new _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  List<Provider> providers = [];

  getProviders() {
    List<Provider> provider = [];
    Floor.instance.database.then((db) async {
      await db.providerDao.getAllProviders().then((value) => value.forEach(
          (element) => provider.add(Provider.fromJson(element.toJson()))));
      setState(() => providers = provider);
    });
  }

  @override
  void initState() {
    getProviders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поставщики'),
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
                    'Список поставщиков',
                    style: AppStyles.headerTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(32)),
                  ),
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
                          builder: (context) => AddProviderPage(
                                onSubmit: (int statusCode) {
                                  if (statusCode == 200 || statusCode == 201) {
                                    setState(() => getProviders());
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
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(24),
                  horizontal: ScreenUtil().setWidth(16)),
              child: Row(
                children: [
                  Expanded(
                    child: DataTable(
                      columnSpacing: 0,
                      rows: providers
                          .map((e) => DataRow(cells: [
                                DataCell(Text(
                                  e.id.toString(),
                                  style: AppStyles.tableTextStyle.copyWith(
                                      fontSize: ScreenUtil().setSp(20)),
                                )),
                                DataCell(Text(
                                  e.name,
                                  style: AppStyles.tableTextStyle.copyWith(
                                      fontSize: ScreenUtil().setSp(20)),
                                )),
                                DataCell(
                                  PopupMenuButton(
                                    onSelected: (String value) {
                                      if (value == 'change') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProviderPage(
                                                      provider: e,
                                                      onSubmit:
                                                          (int statusCode) {
                                                        if (statusCode == 200) {
                                                          setState(() =>
                                                              getProviders());
                                                        }
                                                      },
                                                    ),
                                                fullscreenDialog: true));
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
                                )
                              ]))
                          .toList(),
                      columns: [
                        DataColumn(
                            label: Text(
                          '№',
                          style: AppStyles.tableTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(20)),
                        )),
                        DataColumn(
                            label: Text(
                          'Имя',
                          style: AppStyles.tableTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(20)),
                        )),
                        DataColumn(
                            label: Text(
                          'Действие',
                          style: AppStyles.tableTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(20)),
                        ))
                      ],
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
