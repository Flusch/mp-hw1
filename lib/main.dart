//Yavuz Selim GÜLER
//1306160016
import 'package:flutter/material.dart';
import 'SchulteTable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      home: SchulteTable(),
    );
    return materialApp;
  }
}