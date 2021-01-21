import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:collection/collection.dart";

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

  Future getEmployees() async {
    String token = await storage.read(key: "token");

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
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Image.network(
                                'https://11faa5aded5b.ngrok.io/libs/image/profile/${emp['employee_id']}'),
                          ),
                          title: Text('${emp['first_name']} ${emp['last_name']}'),
                          subtitle: Text('${emp['position_name']}'));
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AdminNewPerson()));
          },
        ));
  }
}
