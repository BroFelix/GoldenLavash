import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/screens/home/components/edit.dart';

class EstimateScreen extends StatefulWidget {
  EstimateResponse estimateResponse;

  EstimateScreen({@required this.estimateResponse});

  @override
  State<StatefulWidget> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(24),
              horizontal: ScreenUtil().setWidth(16)),
          child: DataTable(
            columnSpacing: ScreenUtil().setWidth(32),
            columns: [
              DataColumn(label: Text('№')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('NumWeek')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Doc/num')),
              DataColumn(label: Text('Статус')),
              DataColumn(label: Text('Действие')),
            ],
            rows: widget.estimateResponse.results
                .map(
                  (e) => DataRow(cells: [
                    DataCell(Text(e.id.toString())),
                    DataCell(Text(e.created.year.toString())),
                    DataCell(Text(e.weekNumb.toString())),
                    DataCell(Text(e.user.toString())),
                    DataCell(Text(e.docNumb.toString())),
                    DataCell(Text(e.status.toString())),
                    DataCell(
                      PopupMenuButton(
                        onSelected: (String value) {
                          if (value == 'change') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditScreen(indexOfEdit: e.id,typeOfEdit: 'estimate',),
                                    fullscreenDialog: true));
                          }
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
      ),
    );
  }
}
