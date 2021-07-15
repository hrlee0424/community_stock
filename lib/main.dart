import 'package:community_stock/view/login.dart';
import 'package:community_stock/view/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/boardInfo.dart';
import 'provider/bottomnavigation_provider.dart';
import 'home.dart';
import 'home.dart';
import 'page/homepage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BottomNavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new SplashScreen(),
      ),
    );
  }
}


