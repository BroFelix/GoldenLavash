import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/outlay_category.dart';

class OutlayPage extends StatefulWidget {
  final OutlayCategoryResponse outlayResponse;

  OutlayPage({@required this.outlayResponse});

  @override
  State<StatefulWidget> createState() => _OutlayPageState();
}

class _OutlayPageState extends State<OutlayPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: RaisedButton(
              color: Colors.blue,
              splashColor: Colors.blue,
              textColor: Colors.white,
              child: Text('Добавить'),
              onPressed: () {},
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(700),
            width: ScreenUtil().setWidth(600),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(24),
                horizontal: ScreenUtil().setWidth(16)),
            child: DataTable(
              columnSpacing: ScreenUtil().setWidth(64),
              columns: [
                DataColumn(
                    label: Text('№',
                        style: TextStyle(fontSize: ScreenUtil().setSp(24)))),
                DataColumn(
                    label: Text('Название',
                        style: TextStyle(fontSize: ScreenUtil().setSp(24)))),
                DataColumn(
                    label: Text('Действие',
                        style: TextStyle(fontSize: ScreenUtil().setSp(24)))),
              ],
              rows: widget.outlayResponse.results
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(Text(
                        (e.id ?? e.id).toString(),
                        style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                      )),
                      DataCell(Text(
                        (e.title ?? e.title),
                        style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                      )),
                      DataCell(
                        PopupMenuButton(
                          onSelected: (String value) {
                            if (value == 'change') {
                              return null;
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
    );
  }
}
