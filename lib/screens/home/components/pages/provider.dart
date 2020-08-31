import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/provider.dart';

class ProviderPage extends StatefulWidget {
  final List<Provider> providers;

  ProviderPage({this.providers});

  @override
  State<StatefulWidget> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: RaisedButton(
              child: Text('Добавить'),
              onPressed: () {},
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(24),
                horizontal: ScreenUtil().setWidth(16)),
            child: DataTable(
              rows: widget.providers
                  .map((e) => DataRow(cells: [
                        DataCell(Text(e.id.toString())),
                        DataCell(Text(e.name)),
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
                                value: 'change',
                                child: Text('Изменить'),
                              ),
                            ],
                          ),
                        )
                      ]))
                  .toList(),
              columns: [
                DataColumn(label: Text('№')),
                DataColumn(label: Text('Имя')),
                DataColumn(label: Text('Действие'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
