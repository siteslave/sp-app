import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sps_app/api.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Api api = Api();
  final storage = new FlutterSecureStorage();

  Future doLogin() async {
    try {
      String username = ctrlUsername.text;
      String password = ctrlPassword.text;

      EasyLoading.show(status: 'กรุณารอซักครู่...');

      Response res = await api.login(username, password);

      EasyLoading.dismiss();

      if (res.statusCode == 200) {
        print(res.data);
        String token = res.data['access_token'];
        await storage.write(key: "token", value: token);
        EasyLoading.showSuccess('เข้าสู่ระบบสำเร็จ');

        Navigator.of(context).pop();
      } else {
        print('เกิดข้อผิดพลาด');
        EasyLoading.showError('ไม่สามารถเข้าสู่ระบบได้');
      }
    } on DioError catch (error) {
      EasyLoading.dismiss();
      print(error);
      EasyLoading.showError('ชื่อผู้ใช้งานหรือรหัสผ่าน ไม่ถูกต้อง');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF232F34)),
        backgroundColor: Color(0xFFEDF0F2),
        // title: Text('เข้าสู่ระบบ', style: TextStyle(color: Color(0xFF232F34)),),
      ),
      body: ListView(
        children: [
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                // color: Colors.red,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'))),
          ),
          Center(child: Text('เข้าสู่ระบบ')),
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
                      Validators.required('ระบุชื่อผู้ใช้งาน'),
                      // Validators.email('รูปแบบอีเมล์ไม่ถูกต้อง')
                    ]),
                    controller: ctrlUsername,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        fillColor: Colors.grey[200],
                        filled: true,
                        labelText: 'ชื่อผู้ใช้งาน'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณาระบุรหัสผ่าน';
                      }
                      return null;
                    },
                    controller: ctrlPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.keyboard),
                        fillColor: Colors.grey[200],
                        filled: true,
                        labelText: 'รหัสผ่าน'),
                  ),
                  SizedBox(height: 20),
                  RaisedButton.icon(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: Color(0xFFF9AA33),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // valid
                        String username = ctrlUsername.text;
                        String password = ctrlPassword.text;

                        print(username);
                        print(password);

                        doLogin();
                      }
                    },
                    icon: Icon(Icons.arrow_forward_rounded),
                    label: Text('เข้าสู่ระบบ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
