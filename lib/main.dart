import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:flutter_web_diary/diary_card.dart';
import 'package:flutter_web_diary/diary_entry_model.dart';
import 'package:flutter_web_diary/top_bar_title.dart';
import 'package:provider/provider.dart';
import 'diary_entry_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Answer 3 to add a stream that returns documents
    final diaryEntries =
        Firestore.instance.collection('diaries').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => DiaryEntry.fromDoc(doc)).toList();
    });
    // TODO: Answer 4 to change provider to stream provider
    return StreamProvider<List<DiaryEntry>>(
      create: (_) => diaryEntries,
      child: MaterialApp(
        title: 'My Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.yellow[800],
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/new-entry': (context) => DiaryEntryPage.add(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Provider.of<List<DiaryEntry>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TopBarTitle('Trizda Stores'),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          // width: MediaQuery.of(context).size.width * 3 / 5,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SlimyCard(
                  color: Colors.black,
                  width: 400,
                  topCardHeight: 100,
                  bottomCardHeight: 200,
                  borderRadius: 15,
                  topCardWidget: topCardWidget(),
                  bottomCardWidget:Text("hello",style: TextStyle(color:Colors.white),),
                  slimeEnabled: true,
                ),
              ),
              SizedBox(height: 40),
              if (diaryEntries != null)
                for (var diaryData in diaryEntries)
                  DiaryCard(diaryEntry: diaryData),
              if (diaryEntries == null)
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        elevation: 1.5,
        onPressed: () => Navigator.of(context).pushNamed('/new-entry'),
        tooltip: 'Add To Do',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

Widget topCardWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage()),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'The Rock',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Text(
          'He asks, what your name is. But!',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }

