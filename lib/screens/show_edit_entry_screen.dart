import 'package:flutter/material.dart';

class ShowEditEntryScreen extends StatelessWidget {
  var _index;
  static const routeName = '/show-edit-entry-route';

  //ShowEditEntryScreen(this._index);
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(args['index']),
          Text(args['title']),
        ],
      ),
    );
  }
}
