import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogList extends StatefulWidget {
  final void Function(String string) onSelected;
  String title;
  List<dynamic> list = [];

  DialogList({this.title, this.list, this.onSelected});

  @override
  State<StatefulWidget> createState() => _DialogListState();
}

class _DialogListState extends State<DialogList> {
  var searchText = "";

  bool filterClient(index) {
    return widget.list[index].name.toLowerCase().contains(searchText);
  }

  Widget _getClientListItem(str, index) {
    return ListTile(
      onTap: () {
        widget.onSelected(str[index].name);
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.person),
      title: Text(str[index].name),
    );
  }

  Widget buildList(list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return searchText == null || searchText == ''
            ? _getClientListItem(list, index)
            : filterClient(index)
            ? _getClientListItem(list, index)
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getContent() {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ]),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Поиск ' + widget.title,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide:
                      BorderSide(width: 1.0, color: Colors.black26))),
              onChanged: (val) {
                setState(() {
                  searchText = val;
                });
              },
            ),
          ),
          Expanded(
            child: buildList(widget.list),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getContent(),
    );
  }
}
