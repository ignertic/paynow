import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Paynow',
      theme: ThemeData(),
      home: MyHomePage(title: 'Flutter Paynow Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(.7),
        title: Text(title),
      ),
      body: Stack(
        children: <Widget>[
          // Removed all the widgets inside the Stack
        ],
      ),
    );
  }
}
