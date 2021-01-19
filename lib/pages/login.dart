import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF232F34)),
      backgroundColor: Color(0xFFEDF0F2),
      // title: Text('เข้าสู่ระบบ', style: TextStyle(color: Color(0xFF232F34)),),
    ),body: ListView(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png')
            )
          ),
        ),
        Text('Login'),
      ],
    ),);
  }
}