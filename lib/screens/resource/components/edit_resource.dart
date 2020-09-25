import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/model/resource.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/services/api.dart';
import 'package:golden_app/data/db/model/resource.dart' as resDb;
import 'package:http/http.dart' as http;

class EditResourcePage extends StatefulWidget {
  final resource;
  final Function(int statusCode) onSubmit;

  const EditResourcePage({@required this.resource, @required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _EditResourcePageState();
}

class _EditResourcePageState extends State<EditResourcePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _editTypeController = TextEditingController();
  var resourceType;


  @override
  void initState() {
    _titleController.text = widget.resource.title;
    _editTypeController.text = widget.resource.editType.toString();
    resourceType = widget.resource.resourceType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить сырьё'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),
                right: ScreenUtil().setWidth(24),
                top: ScreenUtil().setHeight(24),
                bottom: ScreenUtil().setHeight(12)),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Название',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),
                right: ScreenUtil().setWidth(24),
                top: ScreenUtil().setHeight(12),
                bottom: ScreenUtil().setHeight(24)),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Тип',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              items: <String>['kitchen', 'part']
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                resourceType = value;
              },
            ),
          ),
          Container(
            child: RaisedButton(
              color: AppColors.buttonColor,
              textColor: Colors.white,
              child: Text('Сохранить'),
              onPressed: () {
                final resource = new Resource(
                  title: _titleController.text,
                  editType: 0,
                  resourceType: resourceType,
                );
                Future.sync( () async {
                  http.Response response = await ApiService.getInstance()
                      .sendResourceById(
                          resource: resource, id: widget.resource.id);
                  if (response.statusCode == 200) {
                    await Floor.instance.database.then((db) => db.resourceDao
                        .insertResource(resDb.Resource.fromJson(
                            json.decode(utf8.decode(response.bodyBytes)))));
                    widget.onSubmit(response.statusCode);
                  }
                });
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
