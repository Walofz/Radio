import 'package:flutter/material.dart';
import 'package:radio_app/page/list.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: RadioApp(),
    ));

class RadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RadioListPage(),
    );
  }
}
