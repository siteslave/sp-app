import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final String username;
  final int userId;

  Setting(this.userId, this.username);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ตั้งค่าการใช้งาน'),
      ),
      body: ListView(
        children: [
          Text("ชื่อผู้ใช้งาน ${widget.username}"),
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ปิดหน้าต่าง'))
        ],
      ),
    );
  }
}
