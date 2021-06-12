import 'package:flutter/material.dart';
import 'package:sliding_menu/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
