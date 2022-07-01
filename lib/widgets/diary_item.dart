import 'package:flutter/material.dart';
import 'package:selftherapy_diaries/screens/entries_list_screen.dart';

class DiaryItem extends StatelessWidget {
  final String diaryId;
  final String diaryTitle;
  final AssetImage diaryImage;

  DiaryItem(this.diaryId, this.diaryTitle, this.diaryImage);

  void selectedDiary(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(EntriesListScreen.routeName, arguments: {'id': diaryId});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedDiary(context),
      child: Card(
        shadowColor: Colors.white,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  diaryTitle,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      fontSize: 20),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: diaryImage,
                fit: BoxFit.cover,
              ),

              // gradient: LinearGradient(
              //     colors: [diaryImage.withOpacity(0.3), diaryImage],
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight),
            ),
          ),
        ),
      ),
    );
  }
}
