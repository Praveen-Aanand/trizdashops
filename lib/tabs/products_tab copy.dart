import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
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
                  topCardHeight: 200,
                  bottomCardHeight: 200,
                  borderRadius: 15,
                  topCardWidget: topCardWidget(),
                  bottomCardWidget: bottomCardWidget(context),
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
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
              image: NetworkImage(
                  'https://lh3.googleusercontent.com/ogw/ADGmqu9MreySYZnUpfghyRzBXhI51jGiyHnIgYK47JM=s32-c-mo')),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
      SizedBox(height: 5),
      Text(
        'Praveen Aanand',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      SizedBox(height: 5),
      Text(
        'Rathna stores',
        style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget bottomCardWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("₹ 2003.3",
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      new Card(
        elevation: 0,
        color: Colors.transparent,
        child: new Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black54, // set border color
                  width: 3.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // set rounded corner radius
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
              ] // make rounded corner of border
              ),
          padding: new EdgeInsets.all(32.0),
          child: Row(
            children: [
              new Column(
                children: <Widget>[
                  new Text('Premium pack',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  new Text('3 months',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ],
              ),
              new SizedBox(height: 30,width: 30,),
              RaisedButton(
                color: Colors.green[700],
                textColor: Colors.white,
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
                child: const Text('Upgrade', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black54, // set border color
                  width: 3.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // set rounded corner radius
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
              ] // make rounded corner of border
              ),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Premium',style: TextStyle(color:Colors.white),),
                  onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.videocam),
                  title: new Text('Platinum',style: TextStyle(color:Colors.white),),
                onTap: () => {},
              ),
              new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Gold',style: TextStyle(color:Colors.white),),
                  onTap: () => {}),new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Silver',style: TextStyle(color:Colors.white),),
                  onTap: () => {}),
            ],
          ),
        );
      });
}
