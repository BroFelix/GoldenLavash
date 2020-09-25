import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/model/qr_response.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api.dart';

class QrScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  ScanResult scanResult;
  var _aspectTolerance = 0.00;

  // var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  QrResponse response;
  DateTime created = DateTime.now();

  String fromJson(Map<String, dynamic> json) {
    return json["id"].toString();
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": 'Отмена',
          "flash_on": "Вкл. Вспышку",
          "flash_off": "Откл. Вспышку",
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'Вы не предоставили разрешения для камеры!';
        });
      } else {
        result.rawContent = 'Неизвестная ошибка: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  @override
  void initState() {
    Future.sync(() async {
      await scan();
      var id = fromJson(json.decode(scanResult.rawContent)).toString();
      response = await ApiService.getInstance()
          .getQRInfo(id);
      // print(response.toJson());
      created = response.created;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      appBar: AppBar(
        title: Text('О продукте'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(24),
              left: ScreenUtil().setWidth(24),
              right: ScreenUtil().setWidth(24)),
          child: response != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text('Товар:',
                              style: AppStyles.headerTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text(response.product,
                              style: AppStyles.contentTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text('Дата производства:',
                              style: AppStyles.headerTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text(
                              '${created.day} ${getMonth(created.month)} ${created.year} г. ${created.hour}:${created.minute}',
                              style: AppStyles.contentTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text('Смена:',
                              style: AppStyles.headerTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text(response.shift,
                              style: AppStyles.contentTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text('Цех:',
                              style: AppStyles.headerTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: Text(response.workshop,
                              style: AppStyles.contentTextStyle
                                  .copyWith(fontSize: ScreenUtil().setSp(24))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(12),
                                horizontal: ScreenUtil().setWidth(12)),
                            child: Text('Доставщик:',
                                style: AppStyles.headerTextStyle.copyWith(
                                    fontSize: ScreenUtil().setSp(24)))),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(12),
                                horizontal: ScreenUtil().setWidth(12)),
                            child: Text(
                                response.deliverUser != null
                                    ? response.deliverUser
                                    : "",
                                style: AppStyles.contentTextStyle.copyWith(
                                    fontSize: ScreenUtil().setSp(24)))),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(24)),
                    DataTable(
                      horizontalMargin: ScreenUtil().setWidth(12),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Сырьё:',
                          style: AppStyles.headerTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(24)),
                        ))
                      ],
                      rows: response.resources
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e,
                                    style: AppStyles.tableTextStyle.copyWith(
                                        fontSize: ScreenUtil().setSp(20))))
                              ]))
                          .toList(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(24)),
                    DataTable(
                      horizontalMargin: ScreenUtil().setWidth(12),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Работники:',
                          style: AppStyles.headerTextStyle
                              .copyWith(fontSize: ScreenUtil().setSp(24)),
                        ))
                      ],
                      rows: response.workers != null
                          ? response.workers
                              .map((e) => DataRow(cells: [DataCell(Text(e))]))
                              .toList()
                          : [],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(24)),
                  ],
                )
              : Center(
                  child: Text(scanResult != null ? scanResult.rawContent : ""),
                ),
        ),
      ),
    );
  }

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
}
