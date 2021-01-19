import 'package:flutter/material.dart';

class Manager extends StatefulWidget {
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ทำเนียบผู้บริการ'),),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('กลุ่มงานประกันสุขภาพ'),
            children: [
              ListTile(title: Text('นายสถิตย์ เรียนพิศ'),subtitle: Text('นักวิชาการคอมพิวเตอร์')),
            ],
            )
        ],
      ),
    );
  }
}