import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:golden_app/services/api.dart';

class EditOutlayItemDialog extends StatefulWidget {
  final item;

  EditOutlayItemDialog({@required this.item});

  @override
  State<StatefulWidget> createState() => _EditOutlayItemDialog();
}

class _EditOutlayItemDialog extends State<EditOutlayItemDialog> {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    _textEditingController.text = widget.item.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: ScreenUtil().setHeight(400),
        width: ScreenUtil().setWidth(600),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
              decoration: BoxDecoration(
                color: AppColors.dialogTitleColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(64),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(24),
                        top: ScreenUtil().setHeight(12)),
                    child: Text(
                      'Изменить расход',
                      textAlign: TextAlign.center,
                      style: AppStyles.dialogTitle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                  vertical: ScreenUtil().setHeight(24)),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: 'Название',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1.0,
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(170),
                    margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(24),
                        top: ScreenUtil().setHeight(16)),
                    child: RaisedButton(
                      textColor: Colors.white,
                      hoverColor: AppColors.dialogCloseButtonHover,
                      color: AppColors.dialogCloseButton,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Закрыть',
                        style: AppStyles.buttonTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(16),
                        right: ScreenUtil().setWidth(24)),
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(174),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.buttonColor,
                      hoverColor: AppColors.buttonColorHover,
                      child: Text(
                        'Изменить',
                        style: AppStyles.buttonTextStyle
                            .copyWith(fontSize: ScreenUtil().setSp(24)),
                      ),
                      onPressed: () {
                        widget.item.title = _textEditingController.text;
                        ApiService.getInstance().insertOutlayItem(widget.item);
                        Floor.instance.database.then((db) =>
                            db.outlayItemDao.insertOutlayItem(widget.item));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
