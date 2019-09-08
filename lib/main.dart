import 'package:anonymo/listdata.dart';
import 'package:anonymo/userSend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(

    MaterialApp(
      title: 'Anonymo',
      home: HomeApp(),
      debugShowCheckedModeBanner: false,
    )
);

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    UserSend(),
    ListData()
  ];

  String username = "Androidmonks";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4baea0),
      appBar: AppBar(title: Text("Anonymo", style: TextStyle(color:Colors.black),),backgroundColor: Color(0xfff1f0cf),),
      body: Container(
        child: Stack(children: <Widget>[
          _widgetOptions.elementAt(_selectedIndex),
        ],),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_media),
              title: Text("Messages")

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.line_style),
                title: Text("Send"))
          ]),
    );
  }
}

