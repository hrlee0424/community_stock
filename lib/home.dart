import 'package:community_stock/provider/bottomnavigation_provider.dart';
import 'package:community_stock/page/homepage.dart';
import 'package:community_stock/page/talkpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/color.dart';
import 'page/mypage.dart';
import 'view/writeboard.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  late BottomNavigationProvider _bottomNavigationProvider;

  // List<Widget> _pages = [HomePage(), TalkPage(), MyPage()];
  List<Widget> _pages = [HomePage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: true);
    return Scaffold(
        /*appBar: AppBar(
         actions: [
           new IconButton(icon: new Icon(Icons.add),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder : (context) => WriteBoard()));
           })
         ],
       ),*/
        body: //_pages[_bottomNavigationProvider.currentPage],
            _showBody(),
        bottomNavigationBar: _showBottomNavigation());
  }

  Widget _showBody() {
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return _pages[0];
        break;
      case 1:
        return _pages[1];
        break;
    }
    return Container();
  }

  Widget _showBottomNavigation() {
    return BottomNavigationBar(
          onTap: (index) => _bottomNavigationProvider.updateCurrentPage(index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            // BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Talk'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'My'),
          ],
          selectedItemColor: CommonColor().basicColor,
          currentIndex: _bottomNavigationProvider.currentPage,
        );
      // },
    // );
  }

}
