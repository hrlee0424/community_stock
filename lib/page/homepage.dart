import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/common/time.dart';
import 'package:community_stock/view/detailview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/widget_style.dart';
import '../view/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetCustom().showAppbar(context, 'STALK') as PreferredSizeWidget?,
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection('boardform')
          .orderBy('regdate', descending: true)
          .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            if(snapshot.data!.size <= 0){
              return Center(child: Text('게시글이 없습니다.'));
            }
            return ListView.separated(
              itemCount: snapshot.data!.size,
              itemBuilder: (_, index){
                DocumentSnapshot ds = snapshot.data!.docs[index];
                Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
               return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(data['title'],),),
                      Row(
                        children: [
                          Text(data['nicname'], style: TextStyle(fontSize: 12)),
                          Text('|', style: TextStyle(fontSize: 12)),
                          Text(TimeDate().timeFormat(data['regdate']), style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    ],
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(ds)));
                  },
                );
              },
              separatorBuilder: (context, index){
                return Divider(thickness: 1,);
              },
              /*children:
              snapshot.data.docs.map((board){
                return Center(
                  child: ListTile(
                    title: Text(board['title']),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView(snapshot.data[index])));
                    },
                  ),
                );
              }).toList(),*/
            );
          },
        ),
      )
    );
  }


}