import 'package:flutter/material.dart';
import 'package:sps_app/helper.dart';

class AdminNewPerson extends StatefulWidget {
  @override
  _AdminNewPersonState createState() => _AdminNewPersonState();
}

enum Sex { male, female }

class _AdminNewPersonState extends State<AdminNewPerson> {
  Helper helper = Helper();

  Sex sex = Sex.male;

  TextEditingController ctrlFirstName = TextEditingController();
  TextEditingController ctrlLastName = TextEditingController();
  TextEditingController ctrlBirthdate = TextEditingController();
  TextEditingController ctrlPosition = TextEditingController();

  void showPositionModal() {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('เลือกตำแหน่ง',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
              Divider(),
              ListTile(
                  title: Text('พยาบาลวิชาชีพ'),
                  onTap: () {
                    setState(() {
                      ctrlPosition.text = 'พยาบาลวิชาชีพ';
                    });
                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Text('นักวิชาการสาธารณสุข'),
                  onTap: () {
                    setState(() {
                      ctrlPosition.text = 'นักวิชาการสาธารณสุข';
                    });
                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Text('นักวิชาการคอมพิวเตอร์'),
                  onTap: () {
                    setState(() {
                      ctrlPosition.text = 'นักวิชาการคอมพิวเตอร์';
                    });
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        );
      },
    );
  }

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
                    controller: ctrlFirstName,
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
                    controller: ctrlLastName,
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
                    controller: ctrlBirthdate,
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
                                  colorScheme: ColorScheme.light()
                                      .copyWith(primary: Color(0xFF344955))),
                              child: child,
                            );
                          },
                          initialDatePickerMode: DatePickerMode.year,
                          firstDate: DateTime(1900, 1, 1),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now());

                      print(picked);
                      print(helper.toThaiDate(picked));
                      setState(() {
                        ctrlBirthdate.text = helper.toThaiDate(picked);
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'วัน/เดือน/ปี เกิด',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                            leading: Radio(
                              groupValue: sex,
                              onChanged: (Sex value) {
                                setState(() {
                                  sex = value;
                                });
                              },
                              value: Sex.male,
                            ),
                            title: Text('ชาย')),
                      ),
                      Expanded(
                        child: ListTile(
                            leading: Radio(
                              groupValue: sex,
                              onChanged: (Sex value) {
                                setState(() {
                                  sex = value;
                                });
                              },
                              value: Sex.female,
                            ),
                            title: Text('หญิง')),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onTap: () {
                      showPositionModal();
                    },
                    readOnly: true,
                    controller: ctrlPosition,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            showPositionModal();
                          }),
                      labelText: 'ตำแหน่ง',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onTap: () {
                      showPositionModal();
                    },
                    readOnly: true,
                    controller: ctrlPosition,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            showPositionModal();
                          }),
                      labelText: 'หน่วยงานต้นสังกัด',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton.icon(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left : 20, right: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    color: Color(0xFFF9AA33),
                      icon: Icon(Icons.save),
                      label: Text('บันทึกข้อมูล'),
                      onPressed: () {

                      })
                ],
              )),
            )
          ],
        ));
  }
}
