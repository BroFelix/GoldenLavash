import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/resources/values/styles.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AddResourceDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddResourceDialogState();
}

class _AddResourceDialogState extends State<AddResourceDialog> {
  GlobalKey<AutoCompleteTextFieldState<String>> GKey1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> Gkey2 = new GlobalKey();

  AutoCompleteTextField searchTextField1;
  AutoCompleteTextField searchTextField2;

  TextEditingController controller1 = new TextEditingController();
  TextEditingController editingController2 = new TextEditingController();

  _AddResourceDialogState();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: ScreenUtil().setHeight(770),
        width: ScreenUtil().setWidth(600),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    height: ScreenUtil().setHeight(64),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(24),
                        top: ScreenUtil().setHeight(24)),
                    child: Text(
                      'Добавить сырье',
                      style: AppStyles.dialogTitle
                          .copyWith(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  bottom: ScreenUtil().setHeight(24)),
              child: searchTextField1 = AutoCompleteTextField<String>(
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    filled: true,
                    hintText: 'Продукт',
                    hintStyle: TextStyle(color: Colors.black)),
                itemSubmitted: (item) {
                  setState(
                      () => searchTextField1.textField.controller.text = item);
                },
                clearOnSubmit: false,
                key: GKey1,
                suggestions: ['Asddfreg', 'Bgfergre', 'Ceferg'],
                itemBuilder: (context, item) {
                  return Container(
                    height: ScreenUtil().setHeight(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item,
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                        ),
                      ],
                    ),
                  );
                },
                itemSorter: (a, b) {
                  return a.compareTo(b);
                },
                itemFilter: (item, query) {
                  return item.toLowerCase().contains(query.toLowerCase());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  bottom: ScreenUtil().setHeight(24)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Количество',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  bottom: ScreenUtil().setHeight(24)),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Цена за единицу',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  bottom: ScreenUtil().setHeight(24)),
              child: searchTextField2 = AutoCompleteTextField<String>(
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: new InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
//                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                    filled: true,
                    hintText: 'Поставщик',
                    hintStyle: TextStyle(color: Colors.black)),
                itemSubmitted: (item) {
                  setState(
                      () => searchTextField2.textField.controller.text = item);
                },
                clearOnSubmit: false,
                key: Gkey2,
                suggestions: [
                  'A',
                  'Asd',
                  'ASD',
                  'Asddfreg',
                  'Bgfergre',
                  'Ceferg'
                ],
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(100),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.compareTo(b);
                },
                itemFilter: (item, query) {
                  return item.toLowerCase().contains(query.toLowerCase());
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(64),
                    width: ScreenUtil().setWidth(128),
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
                    width: ScreenUtil().setWidth(128),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: AppColors.buttonColor,
                      hoverColor: AppColors.buttonColorHover,
                      child: Text('Добавить'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
