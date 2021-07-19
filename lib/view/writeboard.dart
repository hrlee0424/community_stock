
import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/common/color.dart';
import 'package:community_stock/firebase/boardmanage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../common/UserInfo.dart';
import '../common/decoration.dart';
import '../common/widget_style.dart';
import 'package:path/path.dart' as Path;

class WriteBoard extends StatefulWidget {
  // const WriteBoard({Key key}) : super(key: key);
  final DocumentSnapshot? post;
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

  final ImagePicker imagePicker = ImagePicker();
  PickedFile? _image;
  List<PickedFile>? _imageFileList;

  late firebase_storage.Reference ref;
  late CollectionReference imgRef;
  List<File> _imageList = [];

  List<dynamic> readData = [];

  bool uploading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.post != null){
    _titleController.text = widget.post!['title'];
    _contentController.text = widget.post!['contents'];
    }
    imgRef = FirebaseFirestore.instance.collection('images');
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
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('게시글 작성'),
            leading: new IconButton(icon: new Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: (){_showAlertDialog(context);},),
            backgroundColor: CommonColor().basicColor,
          ),
          body: new Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        _inputTitle(),
                        _inputContent(),
                        TextButton(onPressed: _selectDialog, child: Text('사진 추가하기', style: TextStyle(fontSize: 20),)),
                        Container(
                          width: 100, //MediaQuery.of(context).size.width,
                          height: 80,
                          // child: _image == null ? Text('이미지 없음') : Image.file(File(_image!.path)),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            key: UniqueKey(),
                            itemBuilder: (context, index) {
                              return Semantics(
                                child: _imageList.isEmpty ? Text('이미지 없음'): Image.file(File(_imageList[index].path)),
                              );
                            },
                            itemCount: _imageList.isEmpty ? 0 : _imageList.length,
                          ),
                        ),
                        /*StreamBuilder(
                          stream:  FirebaseFirestore.instance
                              .collection('boardform')
                              .doc(widget.post!.id)
                              .snapshots(), builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                          var data = snapshot.data;
                          print(data!.data());
                          List<dynamic> list = data['image'];
                          print('1111111111 ' + list.toString());
                          return ListView(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.vertical,
                                // key: UniqueKey(),
                                itemCount: list.isNotEmpty ? list.length : 0,
                                itemBuilder: (_, int index){
                                  Map<String, dynamic> sp = list[index];
                                  return Container(
                                    child: Image.network(sp['img'].toString()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        ),*/
                        _addButton()
                      ],
                    ),
                    uploading ? new Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('UpLoading...'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(color: CommonColor().basicColor,)
                        ],
                      ),
                    ) : Container(),
                  ],
                )
              ),
          ),
        ), onWillPop: () {
          _showAlertDialog(context);
          return Future(() => false);
    },);
  }

  Widget _inputTitle() {
    return Padding(padding: EdgeInsets.only(top: 20),
    child: TextFormField(
        controller: _titleController,
        focusNode: _titleFocus,
        decoration: FormDecoration().textFormDecoration('제목', '제목을 입력하세요.', '제목을 입력해주세요'),
        validator: (value) {
          if(value!.isEmpty) return '제목을 입력해주세요.';
          else return null;
        }
    ),);
  }

  Widget _inputContent() {
    return Padding(padding: EdgeInsets.only(top: 20),
          child: TextFormField(
            controller: _contentController,
            focusNode: _contentFocus,
            decoration: _decoration(),
            maxLines: 20,
            validator: (value) {
              if(value!.isEmpty) return '내용을 입력해주세요.';
              else return null;
            }
          ));
  }

  InputDecoration _decoration(){
      return InputDecoration(
        labelText: '내용',
        labelStyle: TextStyle(color: CommonColor().basicColor),
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        hintText: '내용을 입력하세요.',
        // fillColor: Color(0xf2a2727),
        // filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: CommonColor().basicColor)
        )
      );
  }

  Widget _addButton(){
    return WidgetCustom().showBtn(40.0, Text('등록하기', style: TextStyle(color: Colors.white)),
        setBoard, CommonColor().basicColor);
  }

  void setBoard(){
    if (formKey.currentState!.validate()) {
      widget.post == null ? _addBoard() : _updateBoard();
    }
  }

  void _updateBoard(){
    BoardManage().updateBoard(widget.post!.id, _titleController.text, _contentController.text);
    Navigator.pop(context);
  }

  void _addBoard(){
    setState(() {
      uploading = true;
    });
    if(_imageList.isEmpty){
      BoardManage().addBoard(UserInfo.userName, _titleController.text, _contentController.text, hashMap);
      Navigator.pop(context);
    }else{
      uploadFile().whenComplete(() {
        BoardManage().addBoard(UserInfo.userName, _titleController.text, _contentController.text, hashMap);
        Navigator.of(context).pop();
      });
    }
  }

  Future getImageFromGallery(ImageSource source) async{
   // var image = await imagePicker.getMultiImage(imageQuality: 100);
    var image = await imagePicker.getImage(source: source);
    setState(() {
      _image = image;
      Navigator.pop(context);
      _imageList.add(File(image!.path));
      if (image.path == null) retrieveLostData();
    });
  }

  List<Map<String, String>> hashMap = [];

  Future uploadFile() async {
    int i = 1;
    for (var img in _imageList) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          // imgRef.add({'url': value});
          hashMap.add({'img' : value});
          i++;
        });
      });
    }
  }

  _selectDialog(){
    return showDialog(context: context, builder: (context){
      return SimpleDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text('사진 가져오기'),
      children: [
        Padding(padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: SimpleDialogOption(
          child: Text('카메라'),
          onPressed: () {getImageFromGallery(ImageSource.camera);},
        ),),
        Padding(padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: SimpleDialogOption(
          child: Text('갤러리'),
          onPressed: () {getImageFromGallery(ImageSource.gallery);},
        ),)
      ],);
    });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await imagePicker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageList.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  void _showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text("작성중인 글이 있습니다. 나가시겠습니까?"),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.pop(context, "취소");
            }, child: Text('취소')),
            TextButton(
              child: Text('나가기'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

}
