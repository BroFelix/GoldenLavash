import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:validators/sanitizers.dart';

class ChangeCount extends StatelessWidget {
  final item;

  TextEditingController _textEditingController = TextEditingController();

  ChangeCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: ScreenUtil().setHeight(360),
        width: ScreenUtil().setWidth(600),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
              decoration: BoxDecoration(
                color: AppColors.dialogTitleColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(children: [
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(64),
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(24),
                      top: ScreenUtil().setHeight(12)),
                  child: Text(
                    'Изменить количество',
                    textAlign: TextAlign.center,
                    style: AppStyles.dialogTitle
                        .copyWith(fontSize: ScreenUtil().setSp(24)),
                  ),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setWidth(24),
                  horizontal: ScreenUtil().setWidth(24)),
              child: TextField(
                onSubmitted: (value) {
                  item.count = toInt(value);
                },
                onEditingComplete: () {
                  item.count = toInt(_textEditingController.text);
                },
                keyboardType: TextInputType.number,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Количество',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Divider(height: 1.0, color: Colors.black),
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
                      child: Text('Закрыть'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(16),
                        right: ScreenUtil().setWidth(24)),
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(170),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.buttonColor,
                      hoverColor: AppColors.buttonColorHover,
                      child: Text('Добавить'),
                      onPressed: () {
                        item.count = toInt(_textEditingController.text);
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
