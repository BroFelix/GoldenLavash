import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(24),
            horizontal: ScreenUtil().setWidth(16)),
        child:Text('Org')
//        DataTable(
//          rows: [],
//          columns: [],
//        ),
      ),
    );
  }
}
