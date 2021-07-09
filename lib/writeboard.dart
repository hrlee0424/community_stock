import 'package:community_stock/common/time.dart';
import 'package:community_stock/firebase/boardmanage.dart';
import 'package:flutter/material.dart';

import 'common/UserInfo.dart';
import 'common/decoration.dart';
import 'common/widget_style.dart';

class WriteBoard extends StatefulWidget {
  const WriteBoard({Key key}) : super(key: key);

  @override
  _WriteBoardState createState() => _WriteBoardState();
}

class _WriteBoardState extends State<WriteBoard> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  FocusNode _titleFocus = new FocusNode();
  FocusNode _contentFocus = new FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _titleFocus.dispose();
    _contentController.dispose();
    _contentFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('글쓰기'),
        ),
        body: new Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Column(
              children: [
                _inputTitle(),
                _inputContent(),
                _addBoard()
              ],
            ),
          ),)
    );
  }

  Widget _inputTitle() {
    return TextFormField(
      controller: _titleController,
      focusNode: _titleFocus,
      decoration: FormDecoration().textFormDecoration('제목', '제목을 입력해주세요'),
    );
  }

  Widget _inputContent() {
    return TextFormField(
      controller: _contentController,
      focusNode: _contentFocus,
      decoration: FormDecoration().textFormDecoration('내용', '내용을 입력해주세요'),
    );
  }

  Widget _addBoard(){
    return WidgetCustom().showBtn(50.0, Text('등록하기'), _end, Colors.amberAccent);
  }

  void _end(){
    BoardManage().addBoard(UserInfo.userName, '11111', _titleController.text, _contentController.text, TimeMagage().getTimeNow());
    Navigator.pop(context);
  }

}
