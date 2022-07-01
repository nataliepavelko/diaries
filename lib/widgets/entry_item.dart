import 'package:flutter/material.dart';
import 'package:selftherapy_diaries/screens/show_edit_entry_screen.dart';

class EntryItem extends StatelessWidget {
  final String _noteTitle;
  final String _date;
  final String _note;
  final int _index;

  EntryItem(this._noteTitle, this._date, this._note, this._index);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ShowEditEntryScreen.routeName,
          arguments: {'index': _index.toString(), 'title': _noteTitle}),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _noteTitle,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Text(_date),
                Divider(),
                Text(
                  _note,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
