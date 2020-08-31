import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/resource.dart';

class ResourcesPage extends StatefulWidget {
  final List<Resource> resources;

  ResourcesPage({@required this.resources});

  @override
  State<StatefulWidget> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: RaisedButton(
              onPressed: () {},
              child: Text('Добавить'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(24),
                horizontal: ScreenUtil().setWidth(16)),
            child: DataTable(
              columnSpacing: ScreenUtil().setWidth(32),
              columns: [
                DataColumn(label: Text('№')),
                DataColumn(label: Text('Название')),
                DataColumn(label: Text('Тип сырья')),
                DataColumn(label: Text('Действие')),
              ],
              rows: widget.resources
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(Text((e.id ?? e.id).toString())),
                      DataCell(Text((e.title ?? e.title))),
                      DataCell(Text(e.resourceType)),
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
