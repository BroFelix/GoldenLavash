import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/expense.dart';
import 'package:golden_app/screens/home/components/edit.dart';

class OutlayScreen extends StatefulWidget {
  final ExpenseResponse expenseResponse;

  OutlayScreen({@required this.expenseResponse});

  @override
  State<StatefulWidget> createState() => _OutlayScreenState();
}

class _OutlayScreenState extends State<OutlayScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(24),
            horizontal: ScreenUtil().setWidth(16)),
        child: DataTable(
          columnSpacing: ScreenUtil().setWidth(32),
          columns: [
            DataColumn(label: Text('№')),
            DataColumn(label: Text('count')),
            DataColumn(label: Text('countOld')),
            DataColumn(label: Text('price')),
            DataColumn(label: Text('amount')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Действие')),
          ],
          rows: widget.expenseResponse.results
              .map(
                (e) => DataRow(cells: [
                  DataCell(Text((e.id ?? e.id).toString())),
                  DataCell(Text((e.count ?? e.count).toString())),
                  DataCell(Text((e.countOld ?? e.countOld).toString())),
                  DataCell(Text((e.price ?? e.price).toString())),
                  DataCell(Text((e.amount ?? e.amount).toString())),
                  DataCell(Text((e.status ?? e.status).toString())),
                  DataCell(
                    PopupMenuButton(
                      onSelected: (String value) {
                        if (value == 'change') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EditScreen(),
                                  fullscreenDialog: true));
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
    );
  }
}
