import 'package:flutter/material.dart';
import 'package:sps_app/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPS Application',
      home: Home()
    );
  }
}
