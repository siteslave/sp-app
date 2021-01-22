import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sps_app/helper.dart';

import '../../api.dart';

class AdminNewPerson extends StatefulWidget {
  @override
  _AdminNewPersonState createState() => _AdminNewPersonState();
}

enum Sex { male, female }

class _AdminNewPersonState extends State<AdminNewPerson> {
  final storage = new FlutterSecureStorage();

  Helper helper = Helper();
  Api api = Api();

  Sex sex = Sex.male;

  List positions = [];
  List departments = [];

  int positionId;
  int departmentId;

  TextEditingController ctrlFirstName = TextEditingController();
  TextEditingController ctrlLastName = TextEditingController();
  TextEditingController ctrlBirthdate = TextEditingController();
  TextEditingController ctrlPosition = TextEditingController();
  TextEditingController ctrlDepartment = TextEditingController();

  Future getPositions() async {
    String token = await storage.read(key: "token");
    try {
      EasyLoading.show(status: "กรุณารอซักครู่...");
      Response res = await api.getPositions(token);
      EasyLoading.dismiss();
      setState(() {
        positions = res.data;
      });
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      EasyLoading.showError('เกิดข้อผิดพลาด');
    }
  }

  Future getDepartments() async {
    String token = await storage.read(key: "token");
    try {
      EasyLoading.show(status: "กรุณารอซักครู่...");
      Response res = await api.getDepartments(token);
      EasyLoading.dismiss();
      setState(() {
        departments = res.data;
      });
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      EasyLoading.showError('เกิดข้อผิดพลาด');
    }
  }

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
              Column(
                children: positions.map((position) {
                  return ListTile(
                      title: Text(position['position_name']),
                      onTap: () {
                        setState(() {
                          ctrlPosition.text = position['position_name'];
                          positionId = int.parse(position['position_id']);
                        });
                        Navigator.of(context).pop();
                      });
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }

  void showDepartmentModal() {
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
                    Text('เลือกหน่วยงานต้นสังกัด',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
              Column(
                children: departments.map((department) {
                  return ListTile(
                      title: Text(department['department_name']),
                      onTap: () {
                        setState(() {
                          ctrlDepartment.text = department['department_name'];
                          departmentId = department['department_id'];
                        });
                        Navigator.of(context).pop();
                      });
                }).toList(),
              )
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
                    onTap: () async {
                      await getPositions();
                      showPositionModal();
                    },
                    readOnly: true,
                    controller: ctrlPosition,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: 'ตำแหน่ง',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onTap: () async {
                      await getDepartments();
                      showDepartmentModal();
                    },
                    readOnly: true,
                    controller: ctrlDepartment,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: 'หน่วยงานต้นสังกัด',
                      fillColor: Colors.grey[200],
                      filled: true,
                      // border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton.icon(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Color(0xFFF9AA33),
                      icon: Icon(Icons.save),
                      label: Text('บันทึกข้อมูล'),
                      onPressed: () {})
                ],
              )),
            )
          ],
        ));
  }
}
