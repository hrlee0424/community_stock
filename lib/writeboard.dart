import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/firebase/boardmanage.dart';
import 'package:flutter/material.dart';

import 'common/UserInfo.dart';
import 'common/decoration.dart';
import 'common/widget_style.dart';

class WriteBoard extends StatefulWidget {
  // const WriteBoard({Key key}) : super(key: key);
  final DocumentSnapshot post;
  WriteBoard({this.post});

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
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.post != null){
    _titleController.text = widget.post['title'];
    _contentController.text = widget.post['contents'];
    }
  }

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
            child: ListView(
              children: [
                _inputTitle(),
                _inputContent(),
                _addButton()
              ],
            ),
          ),)
    );
  }

  Widget _inputTitle() {
    return TextFormField(
      controller: _titleController,
      focusNode: _titleFocus,
      decoration: FormDecoration().textFormDecoration('제목을 입력하세요.', '제목을 입력해주세요'),
        validator: (value) {
          if(value.isEmpty) return '제목을 입력해주세요.';
          else return null;
        }
    );
  }

  Widget _inputContent() {
    return Padding(padding: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: _contentController,
            focusNode: _contentFocus,
            decoration: _decoration(),
            maxLines: 20,
            validator: (value) {
              if(value.isEmpty) return '내용을 입력해주세요.';
              else return null;
            }
          ));
  }

  InputDecoration _decoration(){
      return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        hintText: '내용을 입력하세요.',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      );
  }

  Widget _addButton(){
    return WidgetCustom().showBtn(50.0, Text('등록하기'),
        setBoard, Colors.amberAccent);
  }

  void setBoard(){
    if (formKey.currentState.validate()) {
      widget.post == null ? _addBoard() : _updateBoard();
    }
  }

  void _updateBoard(){
    print('수정수정수정');
    BoardManage().updateBoard(widget.post.id, _titleController.text, _contentController.text);
    Navigator.pop(context);
  }

  void _addBoard(){
    print('추가추가추가');
    BoardManage().addBoard(UserInfo.userName, _titleController.text, _contentController.text);
    Navigator.pop(context);
  }

}
