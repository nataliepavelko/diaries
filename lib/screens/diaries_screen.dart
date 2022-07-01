import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:selftherapy_diaries/widgets/diary_item.dart';
import '../dummy_data.dart';

//test nataliepavelko

class DiariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Logout',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
        title: const Text(
          'Therapy Diaries',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GridView(
          padding: EdgeInsets.all(15),
          children: DUMMY_DIARIES // FIRST WHAT NEED TO CHANGE
              .map(
                (diary) => DiaryItem(
                  diary.id,
                  diary.title,
                  diary.image,
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 450,
            mainAxisExtent: 200,
            childAspectRatio: 4 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          )),
    );
  }
}
