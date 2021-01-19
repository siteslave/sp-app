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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, ),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.grey[300]),
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/mamager.png'),
              )
            ),
          ),
          Center(child: Text('นายมนต์ชัย วิวัฒนาสิทธิพงศ์', style: TextStyle(fontWeight: FontWeight.bold))),
          Center(child: Text('ผู้อำนวยการโรงพยาบาล')),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('รายชื่อบุคลากร', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(
              title: Text('กลุ่มงานประกันสุขภาพ'),
              children: [
                ListTile(title: Text('นายสถิตย์ เรียนพิศ'),subtitle: Text('นักวิชาการคอมพิวเตอร์')),
              ],
              ),
          )
        ],
      ),
    );
  }
}