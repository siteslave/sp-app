import 'package:flutter/material.dart';
import 'package:sps_app/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF344955),
        accentColor: Color(0xFFF9AA33)
      ),
      title: 'SPS Application',
      home: Home()
    );
  }
}
