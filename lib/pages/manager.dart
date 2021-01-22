import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:collection/collection.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sps_app/api.dart';
import 'package:sps_app/pages/admin/admin_new_person.dart';

class Manager extends StatefulWidget {
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  final storage = new FlutterSecureStorage();
  Api api = Api();
  List employees = [];

  String _token;

  File _image;
  final picker = ImagePicker();

  Future uploadFile(File imageFile, int employeeId) async {
    try {
      EasyLoading.show(status: 'อัปโหลดไฟล์...');
      String token = await storage.read(key: "token");
      await api.uploadImage(employeeId, imageFile, token);
      EasyLoading.showSuccess('อัปโหลดสำเร็จ');
    } catch (error) {
      EasyLoading.showError('เกิดข้อผิดพลาด');
      print(error);
    }
  }

  Future getEmployees() async {
    String token = await storage.read(key: "token");
    setState(() {
      _token = token;
    });
    try {
      EasyLoading.show(status: 'กรุณารอซักครู่');
      Response res = await api.getEmployees(token);
      EasyLoading.dismiss();
      // print(res.data);

      if (res.data != null) {
        var _items = groupBy(res.data, (obj) => obj['department_name']);
        print(_items);

        var items = [];
        _items.forEach((key, value) {
          print(key);
          List employee = [];
          value.forEach((emp) {
            employee.add(emp);
          });

          items.add({"department": key, "employees": employee});
        });

        print(items);

        setState(() {
          employees = items;
        });
      }
    } catch (error) {
      EasyLoading.dismiss();
      EasyLoading.showError('ไม่สามารถดึงข้อมูลได้');
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ทำเนียบผู้บริหาร'),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.grey[300]),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/mamager.png'),
                  )),
            ),
            Center(
                child: Text('นายมนต์ชัย วิวัฒนาสิทธิพงศ์',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Center(child: Text('ผู้อำนวยการโรงพยาบาล')),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('รายชื่อบุคลากร',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: employees.map((e) {
                  List _employees = e['employees'];
                  return ExpansionTile(
                    title: Text('${e['department']}'),
                    children: _employees.map((emp) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'แก้ไข',
                            color: Colors.black45,
                            icon: Icons.edit,
                            onTap: () {},
                          ),
                          IconSlideAction(
                            caption: 'อัปโหลด',
                            color: Colors.teal,
                            icon: Icons.camera,
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera,
                                  imageQuality: 50,
                                  maxHeight: 680,
                                  maxWidth: 680);

                              if (pickedFile != null) {
                                File imageFile = File(pickedFile.path);

                                int employeeId =
                                    int.parse(emp['employee_id'].toString());
                                uploadFile(imageFile, employeeId);
                              }
                            },
                          ),
                          IconSlideAction(
                            caption: 'ลบ',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {},
                          ),
                        ],
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: Image.network(
                                'https://b054a57b0de5.ngrok.io/libs/image/profile/${emp['employee_id']}',
                                headers: {"Authorization": "Bearer $_token"},
                              ),
                            ),
                            title: Text(
                                '${emp['first_name']} ${emp['last_name']}'),
                            subtitle: Text('${emp['position_name']}')),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: () async {
            var res = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AdminNewPerson()));

            if (res != null) getEmployees();
          },
        ));
  }
}
