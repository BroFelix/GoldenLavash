import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/screens/home/components/pages/edit_estimate.dart';

class EstimatePage extends StatelessWidget {
  final List<Estimate> estimateResponse;

  EstimatePage({@required this.estimateResponse});

  @override
  Widget build(BuildContext context) {
    print('Bloc created = ${estimateResponse[0].created}');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
            padding: EdgeInsets.symmetric(
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
              rows: estimateResponse
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(Text(e.id.toString())),
                      DataCell(
                          Text(DateTime.tryParse(e.created).year.toString())),
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
                                          EditEstimateScreen(
                                            editEstimate: e,
                                          ),
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
        ],
      ),
    );
  }
}
