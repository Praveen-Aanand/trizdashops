import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/product_card.dart';
import 'package:flutter_web_diary/product_entry_model.dart';
import 'package:flutter_web_diary/top_bar_title.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_diary/product_entry_page.dart';

class ProductsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryEntries =
        Firestore.instance.collection('products').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => DiaryEntry.fromDoc(doc)).toList();
    });
    return StreamProvider<List<DiaryEntry>>(
      create: (_) => diaryEntries,
      child: MaterialApp(
        title: 'shops',
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
          preferredSize: Size.fromHeight(10.0),
          child: TopBarTitle('My Products'),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          // width: MediaQuery.of(context).size.width * 3 / 5,
          child: ListView(
            children: <Widget>[
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

