import 'package:community_stock/homepage.dart';
import 'package:community_stock/talkpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mypage.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _pages = [HomePage(), TalkPage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Commu'),
       ),
       body: _pages[_selectedIndex],
         bottomNavigationBar : BottomNavigationBar(
             onTap: _onItemTapped,
             items: <BottomNavigationBarItem>[
               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Talk'),
               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My'),
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
