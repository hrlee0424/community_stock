import 'package:community_stock/firebase/usermanage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({Key key}) : super(key: key);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
          child: Text('누르시오'),
          onPressed: (){
            // UserManage().addUser('ekfkekf', '닉네임');
          },
        )
    );
  }
}
