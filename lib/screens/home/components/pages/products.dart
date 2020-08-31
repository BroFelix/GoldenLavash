import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/models/product.dart';

class ProductsPage extends StatefulWidget {
  final List<Product> products;

  ProductsPage({@required this.products});

  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: RaisedButton(
              onPressed: () {},
              child: Text('Добавить'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(24),
                horizontal: ScreenUtil().setWidth(16)),
            child: DataTable(
              rows: widget.products
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(Text(e.id.toString())),
                        DataCell(Text(e.title)),
                        DataCell(Text(e.code)),
                        DataCell(Text(e.company.toString())),
                        DataCell(
                          PopupMenuButton(
                            onSelected: (String value) {
                              if (value == 'look') {
                                return null;
                              }
                              if (value == 'change') {
                                return null;
                              }
                              return null;
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'look',
                                child: Text('Посмотреть'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'change',
                                child: Text('Изменить'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
              columns: [
                DataColumn(label: Text('№')),
                DataColumn(label: Text('Название')),
                DataColumn(label: Text('Код')),
                DataColumn(label: Text('Организация')),
                DataColumn(label: Text('Действие')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
