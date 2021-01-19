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

      Column(children: [
        Text('โรงพยาบาลสรรพสิทธิประสงค์',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        Text('Sunpasitthiprasong Hospital'),
        ListTile(leading: Text('ประเภท', style: TextStyle(fontWeight: FontWeight.bold)), title: Text('รัฐ (โรงพยาบาลศูนย์)')),
        ListTile(leading: Text('ที่ตั้ง', style: TextStyle(fontWeight: FontWeight.bold)), title: Text('เลขที่ 122 ถนนสรรพสิทธิ์ ตำบลในเมือง อำเภอเมืองอุบลราชธานี จังหวัดอุบลราชธานี')),

      ]),

      ],
    ),);
  }
}