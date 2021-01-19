import 'package:flutter/material.dart';

import 'setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F2), // Color(0xFFxxxxxx)
      appBar: AppBar(
        title: Text('SPS Application'),
      ),
      body: ListView(
        children: [
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
                  child: Text(
                    'Package Shipped!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
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
              ],
            ),
          ),

          Text('เมนูหลัก'),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text('ประวัติโรงพยาบาล'),
              subtitle: Text('ประวัติความเป็นมาของโรงพยาบาล'),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.home, color: Colors.green,),
            ),
          ),

          Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text('ทำเนียบผู้บริหาร'),
              subtitle: Text('รายชื่อผู้บริหารโรงพยาบาล'),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.group,color: Colors.pink,),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Color(0xFF344955),
          elevation: 0,
          // shape: CircularNotchedRectangle(),
          child: Container(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.settings, size: 32, color: Colors.white),
                    onPressed: () async {
                      var res = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Setting(userId: 20, username: 'Satit')));
                      if (res != null) print('Callback data');
                    }),
                IconButton(
                    icon: Icon(Icons.search, size: 32, color: Colors.white),
                    onPressed: () {}),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.edit), label: Text('ส่งข้อความ'), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
