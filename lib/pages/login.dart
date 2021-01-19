import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        fillColor: Colors.grey[200],
                        filled: true,
                        labelText: 'ชื่อผู้ใช้งาน'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    color: Color(0xFFF9AA33), onPressed: () {}, icon: Icon(Icons.arrow_forward_rounded), label: Text('เข้าสู่ระบบ', style: TextStyle(fontWeight: FontWeight.bold)),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
