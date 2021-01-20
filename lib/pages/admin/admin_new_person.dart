import 'package:flutter/material.dart';

class AdminNewPerson extends StatefulWidget {
  @override
  _AdminNewPersonState createState() => _AdminNewPersonState();
}

class _AdminNewPersonState extends State<AdminNewPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('เพิ่มข้อมูลบุคลากร')),
        body: ListView(
          children: [
            Text('ข้อมูลบุคลากร'),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      labelText: 'ชื่อ',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      labelText: 'นามสกุล',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          helpText: 'เลือกวันเกิด',
                          cancelText: 'ยกเลิก',
                          confirmText: 'ตกลง',
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light().copyWith(
                                  primary: Color(0xFF344955)
                                )
                              ),
                              child: child,
                            );
                          },
                          firstDate: DateTime(1900, 1, 1),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now());
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'วัน/เดือน/ปี เกิด',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                ],
              )),
            )
          ],
        ));
  }
}
