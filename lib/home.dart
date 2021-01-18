import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F2),// Color(0xFFxxxxxx)
        appBar: AppBar(
          title: Text('SPS Application'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                RaisedButton(onPressed: () {},child: Text('หน้าถัดไป'), color: Colors.red,),
                RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 2'), color: Colors.green,),
                RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 3'), color: Colors.yellow),
              ],
            ),
            Row(
              children: [
                RaisedButton(onPressed: () {},child: Text('หน้าถัดไป'), color: Colors.red,),
                RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 2'), color: Colors.green,),
                RaisedButton(onPressed: () {},child: Text('ข้ามไปหน้า 3'), color: Colors.yellow),
              ],
            ),

            Container(
              // height: 100,
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text('Google Express -- 15 mins ago'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text('Package Shipped!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.notification_important),
                      Text('Cucumber Mask Facial has shipped'),
                    ],
                  ),
                )
              ],),
            ),
          ],
        ),
        );
  }
}
