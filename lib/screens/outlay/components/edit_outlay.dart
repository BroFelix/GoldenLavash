import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/outlay_category.dart' as catDb;
import 'package:golden_app/model/outlay_category.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/services/api.dart';

class EditOutlayPage extends StatefulWidget {
  final outlay;
  final Function(int statusCode) onSubmit;

  EditOutlayPage({@required this.outlay, @required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _EditOutlayState();
}

class _EditOutlayState extends State<EditOutlayPage> {
  TextEditingController _nameController = new TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.outlay.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изменить расход'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),right:  ScreenUtil().setWidth(24),
                top: ScreenUtil().setHeight(64),bottom: ScreenUtil().setHeight(32)),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Название категории',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              color: AppColors.buttonColor,
              textColor: Colors.white,
              child: Text(
                'Сохранить',
                style: AppStyles.buttonTextStyle
                    .copyWith(fontSize: ScreenUtil().setSp(18)),
              ),
              onPressed: () {
                String title =
                    _nameController.text != widget.outlay.title
                        ? _nameController.text
                        : widget.outlay.title;
                OutlayCategory category =
                    new OutlayCategory(id: widget.outlay.id, title: title);
                Future.sync(() async {
                  final response = await ApiService.getInstance()
                      .sendOutlayCategoryById(
                          category: category, id: widget.outlay.id);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    await Floor.instance.database.then((db) =>
                        db.outlayCategoryDao.insertOutlayCategory(
                            catDb.OutlayCategory.fromJson(category.toJson())));
                    widget.onSubmit(response.statusCode);
                  }
                });
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
