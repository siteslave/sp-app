import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('ประวัติโรงพยาบาล'),
    ), body: ListView(
      children: [
        Image(image: AssetImage('assets/images/hospital.jpg'), height: 100,),
      ],
    ),);
  }
}