import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:selftherapy_diaries/screens/add_new_entry_screen.dart';
import 'package:selftherapy_diaries/widgets/entry_item.dart';

class EntriesListScreen extends StatelessWidget {
  static const routeName = '/entries-route';

  void _createNewEnrty(BuildContext ctx) {
    Navigator.pushNamed(ctx, AddNewEntrySceeen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My notes',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          // StreamBuilder принимает два именнов аргумента stream and builder
          stream: FirebaseFirestore.instance
              .collection('diaries/FRiZMfL6cIi20gk9UKQR/notes')
              .snapshots(), //и snapshots - это замечательный метод, который мы можем вызывать для коллекции,
          //snapshots возвращает поток.//Теперь, поскольку это поток, это означает, что он будет выдавать новые значения
          //при изменении данных, так что тот аспект данных в реальном времени, о котором я упоминал ранее,
          // он позволяет нам настроить слушателя через Firebase
          //И всякий раз, когда данные там изменяются, этот слушатель будет уведомлен автоматически,
          // и мы сможем повторно выполнить перерисовку нашего виджета сновыми данными и тд,
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            //List<QueryDocumentSnapshot<Object>> documents;
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final documents = streamSnapshot.data!.docs;
            //эта ф-ция builder будет выполняться каждый раз, когда получаем новое значение
            return ListView.builder(
              itemCount: documents.length,
              // DUMMY_ENTRIES.where((note) => note.diaryId == diaryId).length,
              itemBuilder: (ctx, index) =>
                  // NoteItem(diaryId),
                  Container(
                padding: EdgeInsets.all(9),
                child: EntryItem(documents[index]['title'],
                    documents[index]['date'], documents[index]['text'], index),
                // this is a test
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        elevation: 5,
        onPressed: () => _createNewEnrty(context),
      ),
    );
  }
}
