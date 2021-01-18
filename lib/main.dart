import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPS Application',
      home: Scaffold(
          appBar: AppBar(
            title: Text('SPS Application'),
          ),
          body: Text('xxxxx')),
    );
  }
}
