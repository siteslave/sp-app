import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SPS Application'),
        ),
        body: Row(
          children: [
            RaisedButton(onPressed: () {},child: Text('หน้าถัดไป'), color: Colors.red,),
            RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 2'), color: Colors.green,),
            RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 3'), color: Colors.yellow),
          ],
        ));
  }
}
