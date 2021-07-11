import 'package:community_stock/page/homepage.dart';
import 'package:community_stock/page/talkpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'page/mypage.dart';
import 'writeboard.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // List<Widget> _pages = [HomePage(), TalkPage(), MyPage()];
  List<Widget> _pages = [HomePage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /*appBar: AppBar(
         actions: [
           new IconButton(icon: new Icon(Icons.add),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder : (context) => WriteBoard()));
           })
         ],
       ),*/
       body: _pages[_selectedIndex],
         bottomNavigationBar : BottomNavigationBar(
             onTap: _onItemTapped,
             items: <BottomNavigationBarItem>[
               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
               // BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Talk'),
               BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'My'),
             ],
             currentIndex: _selectedIndex,
         ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
