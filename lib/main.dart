import 'package:anonymo/listdata.dart';
import 'package:anonymo/userSend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'UserIdDB.dart';
import 'firebasedatabase.dart';

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

  UserIdDb userIdDb = UserIdDb();

  List<Slide> slides = new List();

  FireBaseUtils _fireBaseUtils = new FireBaseUtils();

  TextEditingController _colorController = new TextEditingController();

  TextEditingController _countryController = new TextEditingController();

  TextEditingController _nameController = new TextEditingController();

  TextEditingController _idController = new TextEditingController();

  String userId = "";

  void formRandomName(String name) {
    userId = userId + name;
    setState(() {
      _idController.text = userId;
    });
    print(userId);
  }

  Future<String> getUserId()
  {
    return null;
  }

  void initState()
  {
    super.initState();

    slides.add(
      new Slide(
        title: "FAVORITE COLOR",
        description: "We will try to form something super interesting with your Favorite Color",
        centerWidget: TextField(
          controller: _colorController,
          onEditingComplete: (){
            formRandomName(_colorController.text);
          },

        ),

        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "COUNTRY",
        description: "We Will Form Something with your favorite country",
        centerWidget: TextField(
          controller: _countryController,
          onEditingComplete: (){
            formRandomName(_countryController.text);
          },
        ),
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "YOUR NAME",
        description:
        "Don't Worry We Wont Let Anyone know your Identity!",
        centerWidget: TextField(
          controller: _nameController,
          onEditingComplete: (){
            formRandomName(_nameController.text);
          },
        ),
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title:"YOUR ID",
        description: "This is your ID! Should you choose to accept it!",
        centerWidget: TextField(
          controller: _idController,
          onChanged: (String userId){
          },
        ),
        backgroundColor: Color(0xff203152)

      )
    );
  }

  String username = "Androidmonks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context){
          return FutureBuilder(
            future: userIdDb.retrieveUserId(),
            builder: (context, snapshot) {
              print("Snapshot");
              print(snapshot);
              if(snapshot.connectionState == ConnectionState.done)
                {
                  print("Inside connection state done");
                  print(snapshot.data);
                  if (snapshot.data == null)
                    {
                      return Center(child: CircularProgressIndicator());
                    }
                  else if (snapshot.data == "")
                    {
                      return IntroSlider(
                        slides: this.slides,
                        onDonePress: () {
                          if (_idController.text == null || _idController.text == "") {
                            Scaffold.of(context).showSnackBar(new SnackBar(
                                content: Text("You havent entered any UserId")));
                          }
                          else {
                            if (_idController.text.length > 5) {
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: Text(
                                    "Are you sure about:" + _idController.text),
                                action: SnackBarAction(
                                  label: "Sure",
                                  onPressed: () async{
                                    bool firebaseResult = await _fireBaseUtils.validateUsername(_idController.text);
                                    print("Response");
                                    print(firebaseResult);
                                    if(firebaseResult)
                                      {
                                        _fireBaseUtils.writeMessage(_idController.text, "welcome");
                                        userIdDb.insertUserId(_idController.text);
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeWidget()),
                                      );
                                    }
                                    else
                                      {
                                        Scaffold.of(context).showSnackBar(new SnackBar(
                                            content: Text("This ID is already taken. Try another")));
                                      }
                                  },
                                ),
                              )

                              );
                            }
                          }
                        },
                      );
                    }
                  return HomeWidget();
                }
              print("Waiting for future to return value");
              return CircularProgressIndicator();

            }

          );
        },
      ),
    );

  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    UserSend(),
    ListData()
  ];

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

