import 'package:flutter/material.dart';
import 'package:flutter_web_diary/product_entry_model.dart';
import 'package:flutter_web_diary/product_entry_page.dart';
import 'package:flutter_web_diary/pop_up_menu.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key key,
    @required this.diaryEntry,
  }) : super(key: key);

  final DiaryEntry diaryEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: EdgeInsets.symmetric(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack( 
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              right: 0,
              top: 0,
              child:  PopUpMenu(diaryEntry: diaryEntry)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:Colors.orange.withAlpha(40),
                    ),
                    Text(
                    diaryEntry.emoji, 
                    style: TextStyle(fontSize: 70),
                  ),
                  ],
                ),
                // SizedBox(height: 5),
                 Text(
                   diaryEntry.title,
                  style: TextStyle(fontSize: 14),
                ),
               
                Text(
                   diaryEntry.body,
                  style: TextStyle(fontSize: 14),
                ),
                 
              ],
            ),
          ],
        ),
      )
       
    );
  }
}
