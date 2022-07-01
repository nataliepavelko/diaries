import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class AddNewEntrySceeen extends StatefulWidget {
  static final String routeName = '/new-entry-route';

  @override
  _AddNewEntrySceeenState createState() => _AddNewEntrySceeenState();
}

class _AddNewEntrySceeenState extends State<AddNewEntrySceeen> {
  var _date = DateTime.now();
  var _title = '';
  var _enteredNote = '';

  String _formatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat.yMEd();
    String formatted = dateFormat.format(dateTime);
    return formatted;
  }

  void _saveNote(String title, DateTime date, String input) {
    final String formattedDate = _formatter(date);
    // в параметри передать сам текст value
    FirebaseFirestore.instance
        .collection(
            'diaries/FRiZMfL6cIi20gk9UKQR/notes') // в Firebase документ добавляется в виде map
        .add({
      'title': title,
      'date': formattedDate,
      'text': input,
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New entry'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Title'),
                  onChanged: (title) {
                    _title = title;
                  },
                ),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                Text(
                  _formatter(_date), // отфоратировать дату
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: 'Write  your feelings here...'),
                  maxLines: 20,
                  onChanged: (value) {
                    setState(() {
                      _enteredNote = value;
                    });
                  },
                  // controller: ,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _enteredNote.trim().isEmpty
            ? null
            : () {
                _saveNote(_title, _date, _enteredNote);
                Navigator.of(context).pop();
                // new entry widget
              },
      ),
    );
  }
}
