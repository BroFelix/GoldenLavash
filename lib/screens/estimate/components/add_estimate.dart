import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/estimate.dart' as estimateDb;
import 'package:golden_app/model/estimate.dart';
import 'package:golden_app/model/user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/screens/estimate/components/edit_estimate.dart';

import 'package:golden_app/services/api.dart';
import 'package:intl/intl.dart';

class AddEstimatePage extends StatefulWidget {
  final Function(int statusCode) onSubmit;

  AddEstimatePage({@required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _AddEstimatePageState();
}

class _AddEstimatePageState extends State<AddEstimatePage> {
  final TextEditingController docNum = TextEditingController();
  User curUser;

  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      curUser = User.fromJson(await getUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    sendEstimate(context) {
      Estimate estimate = new Estimate(
        weekNumb: weekNumber(),
        created: DateTime.now().toIso8601String(),
        docNumb: docNum.text,
        user: curUser.id,
        company: curUser.company,
      );
      Future.sync(() async {
        final response =
            await ApiService.getInstance().sendEstimate(estimate);
        if (response.statusCode == 200) {
          var item =
              Estimate.fromJson(json.decode(utf8.decode(response.bodyBytes)));
          bool inserted = false;
          await Floor.instance.database.then((db) {
            db.estimateDao
                .insertEstimate(estimateDb.Estimate.fromJson(item.toJson()));
            inserted = true;
          });
          if (inserted) {
            widget.onSubmit(response.statusCode);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => EditEstimateScreen(
                    editEstimate: item,
                    onSubmit: (inserted) {
                      if (inserted) widget.onSubmit(200);
                    }),
                fullscreenDialog: true));
          } else
            Navigator.pop(context);
        } else
          Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить закупку'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(64),
                vertical: ScreenUtil().setHeight(64)),
            child: TextField(
              controller: docNum,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Номер договора',
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(128),
            width: ScreenUtil().setWidth(256),
            alignment: Alignment.center,
            child: RaisedButton(
              textColor: Colors.white,
              splashColor: Colors.blue,
              focusColor: Colors.blue,
              color: AppColors.buttonColor,
              child: Text(
                'Добавить',
                style: AppStyles.buttonTextStyle
                    .copyWith(fontSize: ScreenUtil().setSp(24)),
              ),
              onPressed: () {
                sendEstimate(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  int weekNumber() {
    var date = DateTime.now();
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}
