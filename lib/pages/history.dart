import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติโรงพยาบาล'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/hospital.jpg'),fit: BoxFit.fill)
            ),
          ),
          SizedBox(height: 10),
          Column(children: [
            Text(
              'โรงพยาบาลสรรพสิทธิประสงค์',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('Sunpasitthiprasong Hospital'),
            ListTile(
                leading: Text('ประเภท',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                title: Text('รัฐ (โรงพยาบาลศูนย์)')),
            ListTile(
                leading: Text('ที่ตั้ง',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                title: Text(
                    'เลขที่ 122 ถนนสรรพสิทธิ์ ตำบลในเมือง อำเภอเมืองอุบลราชธานี จังหวัดอุบลราชธานี')),
          ]),
          Divider(),
          ListTile(
              leading: Text('ก่อตั้ง',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text('3 มกราคม พ.ศ. 2479')),
          ListTile(
              leading: Text('ผู้อำนวยการ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text('นายแพทย์มนต์ชัย วิวัฒนาสิทธิพงศ์')),
          ListTile(
              leading:
                  Text('เตียง', style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text('1,427 เตียง')),
          ListTile(
              leading:
                  Text('เว็บไซต์', style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text('http://www.sappasit.go.th')),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('ประวัติ',style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green[50]),
            child: Text('โรงพยาบาลสรรพสิทธิประสงค์ เป็นโรงพยาบาลศูนย์ ประจำจังหวัดอุบลราชธานี และเป็นโรงพยาบาลศูนย์แห่งแรกของเขตบริการสุขภาพเขต10 สังกัดกระทรวงสาธารณสุข ให้บริการรักษาทั่วไปแก่ผู้ป่วยในและผู้ป่วยนอก ในเขตพื้นที่ภาคตะวันออกเฉียงเหนือตอนล่าง เขตบริการสุขภาพที่10(อุบลราชธานี ศรีสะเกษ ยโสธร อำนาจเจริญ มุกดาหาร)และพื้นที่ใกล้เคียง และเป็นศูนย์แพทยศาสตร์ศึกษาระดับชั้นคลินิก ให้กับคณะแพทยศาสตร์ มหาวิทยาลัยขอนแก่น และวิทยาลัยแพทยศาสตร์และการสาธารณสุข มหาวิทยาลัยอุบลราชธานี โดยเป็นสถานพยาบาลที่ตั้งอยู่บนพื้นที่ประทานของ หม่อมเจ้าอุปลีสาณ ชุมพล และ หม่อมเจ้ากมลีสาณ ชุมพล ซึ่งเป็นที่ดินตกทอดมาเป็นมรดกในบริเวณที่เรียกว่า "สวนโนนดง" ของพลตรีพระเจ้าบรมวงศ์เธอ กรมหลวงสรรพสิทธิประสงค์ ข้าหลวงต่างพระองค์สำเร็จราชการมณฑลลาวกาว (มณฑลอีสาน)'))
        ],
      ),
    );
  }
}
