import 'package:flutter/material.dart';
import 'package:hackernews_topstories/services/locator.dart';
import 'package:hackernews_topstories/view/newspage.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: NewsPage(),
    );
  }
}
