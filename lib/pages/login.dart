import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณาระบุชื่อผู้ใช้งาน';
                      }
                      return null;
                    },
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
                    if(_formKey.currentState.validate()) {
                      // valid
                      String username = ctrlUsername.text;
                      String password = ctrlPassword.text;

                      print(username);
                      print(password);
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
