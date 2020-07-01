import 'package:flutter/material.dart';
import 'package:flutter_web_diary/product_entry_button.dart';
import 'package:flutter_web_diary/product_entry_model.dart';
import 'package:flutter_web_diary/emoji_helpers.dart';

class DiaryEntryPage extends StatefulWidget {
  const DiaryEntryPage({
    Key key,
    this.diaryAction,
    this.diaryEntry,
  }) : super(key: key);

  const DiaryEntryPage.edit(
      {Key key, this.diaryAction = DiaryAction.edit, this.diaryEntry})
      : super(key: key);

  const DiaryEntryPage.add(
      {Key key, this.diaryAction = DiaryAction.add, this.diaryEntry})
      : super(key: key);

  const DiaryEntryPage.read(
      {Key key, this.diaryAction = DiaryAction.read, this.diaryEntry})
      : super(key: key);

  final DiaryEntry diaryEntry;

  final DiaryAction diaryAction;
  @override
  _DiaryEntryPageState createState() => _DiaryEntryPageState();
}

class _DiaryEntryPageState extends State<DiaryEntryPage> {
  String _emoji;
  TextEditingController titleController;
  TextEditingController bodyTextController;
  bool isReadOnly;
  @override
  void initState() {
    _emoji = widget.diaryEntry?.emoji ?? '';
    titleController =
        TextEditingController(text: widget.diaryEntry?.title ?? '');
    bodyTextController =
        TextEditingController(text: widget.diaryEntry?.body ?? '');
    isReadOnly = widget.diaryAction == DiaryAction.read;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                if (isReadOnly)
                  Text(_emoji ?? '', style: TextStyle(fontSize: 65)),
                if (!isReadOnly)
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                       PopupMenuItem(
                          child: Text('💡 electronics'),
                          value: Emoji.electronics,
                        ),
                        PopupMenuItem(
                          child: Text('👶🏽 baby care'),
                          value: Emoji.babycare,
                        ),PopupMenuItem(
                          child: Text('📺 home appliances'),
                          value: Emoji.homeappliances,
                        ),PopupMenuItem(
                          child: Text('👗 fasion'),
                          value: Emoji.fasion,
                        ),PopupMenuItem(
                          child: Text('🍎 fruits'),
                          value: Emoji.fruits,
                        ),PopupMenuItem(
                          child: Text('🥕 vegitables'),
                          value: Emoji.vegitables,
                        ),
                      ];
                    },
                    child: _emoji.isEmpty
                        ? Text('category')
                        : Text(
                            _emoji,
                            style: TextStyle(
                              fontSize: 65,
                            ),
                          ),
                    onSelected: (selectedEmoji) {
                      setState(() {
                        _emoji = emojiSelected(selectedEmoji);
                      });
                    },
                  ),
                // Title
                TextField(
                  readOnly: isReadOnly,
                  controller: titleController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: isReadOnly ? '' : 'Name',
                  ),
                ),
                // Body text
                TextField(
                  readOnly: isReadOnly,
                  controller: bodyTextController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration.collapsed(
                    hintText: 'discription',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isReadOnly
          ? SizedBox()
          : DiaryEntryButton(
              titleController: titleController,
              bodyTextController: bodyTextController,
              emoji: _emoji,
              widget: widget,
            ),
    );
  }

  @override
  void dispose() {
    _emoji = null;
    titleController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }
}

enum DiaryAction { edit, add, read }
