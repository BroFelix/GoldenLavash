import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/estimate.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/screens/estimate/components/add_estimate.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/screens/estimate/components/edit_estimate.dart';

class EstimatePage extends StatefulWidget {
  static const route = '/estimate';

  @override
  State<StatefulWidget> createState() => new _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  List<Estimate> estimateResponse = [];
  EstimateDataSource estimateDataSource;

  // var formatter = NumberFormat('#,###.#');

  @override
  void initState() {
    estimateDataSource = new EstimateDataSource(context, [], 0);
    getEstimateData();
    super.initState();
  }

  getEstimateData() {
    estimateResponse.clear();
    Future.sync(() async {
      await Floor.instance.database.then((db) =>
          db.estimateDao.getAllEstimates().then((est) => est.forEach((e) {
                estimateResponse.add(Estimate.fromJson(e.toJson()));
                // print(e.id);
              })));
      // print('get func ${estimateResponse.length}');
      setState(() {
        estimateDataSource = EstimateDataSource(
            context, estimateResponse, estimateResponse.length);
      });
    });
  }

  int _rowsPerPageEstimate = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int _sortColumnIndex;

  List<int> rowsPerPage = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Закупки'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          actions: [
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
                    builder: (BuildContext context) =>
                        AddEstimatePage(onSubmit: (int statusCode) {
                          if (statusCode == 200)
                            setState(() {
                              getEstimateData();
                            });
                        }),
                    fullscreenDialog: true));
              },
            ),
          ],
          availableRowsPerPage: rowsPerPage,
          columnSpacing: ScreenUtil().setWidth(46),
          sortAscending: _sortAscending,
          sortColumnIndex: _sortColumnIndex,
          rowsPerPage: _rowsPerPageEstimate,
          source: estimateDataSource,
          header: Text('Список закупок'),
          columns: [
            DataColumn(
                label: Text(
              '№',
              style: AppStyles.tableTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(20)),
            )),
            DataColumn(
                label: Text(
              'Дата/создан',
              style: AppStyles.tableTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(20)),
            )),
            DataColumn(
                label: Text(
              'Номер/док.',
              style: AppStyles.tableTextStyle
                  .copyWith(fontSize: ScreenUtil().setSp(20)),
            )),
            DataColumn(
                label: Text(
              'Статус',
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
        ),
      ),
    );
  }
}

class EstimateDataSource extends DataTableSource {
  final List<Estimate> _results;
  final context;
  int _resultsSize = 0;
  int _selectedCount = 0;

  EstimateDataSource(this.context, this._results, this._resultsSize);

  // void _sort<T>(Comparable<T> getField(Estimate d), bool ascending) {
  //   _results.sort((Estimate a, Estimate b) {
  //     if (!ascending) {
  //       final Estimate c = a;
  //       a = b;
  //       b = c;
  //     }
  //     final Comparable<T> aValue = getField(a);
  //     final Comparable<T> bValue = getField(b);
  //     return Comparable.compare(aValue, bValue);
  //   });
  //   notifyListeners();
  // }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return 'январь';
      case 2:
        return 'февраль';
      case 3:
        return 'март';
      case 4:
        return 'апрель';
      case 5:
        return 'май';
      case 6:
        return 'июнь';
      case 7:
        return 'июль';
      case 8:
        return 'августь';
      case 9:
        return 'сентябрь';
      case 10:
        return 'октябрь';
      case 11:
        return 'ноябрь';
      case 12:
        return 'декабрь';
      default:
        return '';
    }
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final Estimate e = _results[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(
          e.id.toString(),
          style: AppStyles.tableTextStyle
              .copyWith(fontSize: ScreenUtil().setSp(20)),
        )),
        DataCell(
          Text(
            '${DateTime.parse(e.created).day} ${getMonth(DateTime.parse(e.created).month)} ${DateTime.parse(e.created).year}\n${DateTime.parse(e.created).hour}:${DateTime.parse(e.created).minute < 10 ? '0${DateTime.parse(e.created).minute.toString()}' : DateTime.parse(e.created).minute}',
            style: AppStyles.tableTextStyle
                .copyWith(fontSize: ScreenUtil().setSp(20)),
          ),
        ),
        DataCell(Text(
          e.docNumb.toString(),
          style: AppStyles.tableTextStyle
              .copyWith(fontSize: ScreenUtil().setSp(20)),
        )),
        DataCell(Text(
          e.status.toString(),
          style: AppStyles.tableTextStyle
              .copyWith(fontSize: ScreenUtil().setSp(20)),
        )),
        DataCell(
          PopupMenuButton(
            onSelected: (String value) {
              if (value == 'change') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        EditEstimateScreen(editEstimate: e),
                    fullscreenDialog: true));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'change',
                child: Text('Изменить'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _resultsSize;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
