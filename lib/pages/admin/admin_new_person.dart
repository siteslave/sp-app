import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sps_app/helper.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../api.dart';

class AdminNewPerson extends StatefulWidget {
  final int employeeId;

  AdminNewPerson({this.employeeId});

  @override
  _AdminNewPersonState createState() => _AdminNewPersonState();
}

enum Sex { male, female }

class _AdminNewPersonState extends State<AdminNewPerson> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

  Helper helper = Helper();
  Api api = Api();

  Sex sex = Sex.male;

  List positions = [];
  List departments = [];

  int positionId;
  int departmentId;
  DateTime birthdate;

  double lat;
  double lng;

  TextEditingController ctrlFirstName = TextEditingController();
  TextEditingController ctrlLastName = TextEditingController();
  TextEditingController ctrlBirthdate = TextEditingController();
  TextEditingController ctrlPosition = TextEditingController();
  TextEditingController ctrlDepartment = TextEditingController();

  String placeName = 'ไม่รู้จัก';

  Future getLocationName() async {
    try {
      Response res = await api.getCheckInPlace(lat, lng);
      print(res);
      setState(() {
        placeName = res.data['display_name'];
      });
    } catch (error) {
      print(error);
    }
  }

  Future getCurrentLocation() async {
    Position position = await _determinePosition();
    print(position);
    if (position.latitude != null && position.longitude != null) {
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
      });

      getLocationName();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.showError('กรุณาเปิด GPS');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future saveEmployee(String firstName, String lastName, String birthdate,
      String sex, int departmentId, int positionId) async {
    String token = await storage.read(key: "token");
    if (lat != null && lng != null) {
      try {
        EasyLoading.show(status: "กำลังบันทึก...");
        await api.saveEmployee(firstName, lastName, birthdate, sex,
            departmentId, positionId, lat, lng, token);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("บันทึกสำเร็จ");
        Navigator.of(context).pop(true);
      } catch (error) {
        EasyLoading.dismiss();
        print(error);
        EasyLoading.showError('เกิดข้อผิดพลาด');
      }
    } else {
      EasyLoading.showError('กรุณาระบุพิกัด');
    }
  }

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
  void initState() {
    super.initState();
    getCurrentLocation();
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
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: Validators.compose([
                          Validators.required('กรุณาระบุชื่อ'),
                          Validators.maxLength(50, 'ไม่เกิน 50 ตัวอักษร'),
                          Validators.minLength(2, '2 ตัวอักษรขึ้นไป')
                        ]),
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
                        validator: Validators.compose([
                          Validators.required('กรุณาระบุสกลุ'),
                          Validators.maxLength(50, 'ไม่เกิน 50 ตัวอักษร'),
                          Validators.minLength(2, '2 ตัวอักษรขึ้นไป')
                        ]),
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
                        validator: Validators.required('กรุณาระบุวันที่'),
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
                                      colorScheme: ColorScheme.light().copyWith(
                                          primary: Color(0xFF344955))),
                                  child: child,
                                );
                              },
                              initialDatePickerMode: DatePickerMode.year,
                              firstDate: DateTime(1900, 1, 1),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now());

                          setState(() {
                            birthdate = picked;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('พิกัด: $lat, $lng'),
                          IconButton(
                              icon:
                                  Icon(Icons.location_pin, color: Colors.green),
                              onPressed: () {
                                getCurrentLocation();
                              })
                        ],
                      ),
                      Text(placeName, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                      SizedBox(height: 10),
                      RaisedButton.icon(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Color(0xFFF9AA33),
                          icon: Icon(Icons.save),
                          label: Text('บันทึกข้อมูล'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              String _firstName = ctrlFirstName.text;
                              String _lastName = ctrlLastName.text;
                              String _birthdate = helper.toMySQLDate(birthdate);
                              String _sex = sex == Sex.male ? 'M' : 'F';
                              int _positionId = positionId;
                              int _departmentId = departmentId;

                              saveEmployee(_firstName, _lastName, _birthdate,
                                  _sex, _departmentId, _positionId);
                            }
                          })
                    ],
                  )),
            )
          ],
        ));
  }
}
