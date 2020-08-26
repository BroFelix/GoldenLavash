import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganisationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrganisationsScreenState();
}

class _OrganisationsScreenState extends State<OrganisationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(24),
            horizontal: ScreenUtil().setWidth(16)),
        child: DataTable(
          rows: [],
          columns: [],
        ),
      ),
    );
  }
}
