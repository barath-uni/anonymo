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
        title: "Favourite Color!",
        description: "We will try to form your avatar with your Favorite Color",
        centerWidget: TextField(
          controller: _colorController,
          decoration: InputDecoration(
            labelText: "Enter Color",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(20.0),
              borderSide: new BorderSide(
              color: Colors.white
              ),
            ),
            //fillColor: Colors.green
          ),
          onEditingComplete: (){
            formRandomName(_colorController.text);

          },
        ),
        styleTitle: TextStyle(fontFamily: "Poppins", color: Colors.white),
        styleDescription: TextStyle(fontFamily: "Poppins"),
        backgroundColor: Color(0xfff88379),
      ),
    );
    slides.add(
      new Slide(
        title: "Country?",
        description: "Do not worry. No location tracking.Promise!",
        centerWidget: TextField(
          controller: _countryController,
            decoration: InputDecoration(
              labelText: "Enter Country",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0),
                borderSide: new BorderSide(
                    color: Colors.white
                ),
              ),
              //fillColor: Colors.green
            ),
          onEditingComplete: (){
            formRandomName(_countryController.text);
          },
          style: TextStyle(fontFamily: "Poppins"),
        ),
        styleTitle: TextStyle(fontFamily: "Poppins", color:Colors.white),
        styleDescription: TextStyle(fontFamily: "Poppins"),
        backgroundColor: Color(0xff4baea0),
      ),
    );
    slides.add(
      new Slide(
        title: "Name?",
        description:
        "No one will know your name! But its easy to recognise.",
        centerWidget: TextField(
          controller: _nameController,
            decoration: InputDecoration(
              labelText: "Enter Color",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0),
                borderSide: new BorderSide(
                    color: Colors.white
                ),
              ),
              //fillColor: Colors.green
            ),
          onEditingComplete: (){
            formRandomName(_nameController.text);
          },
        ),
        styleTitle: TextStyle(fontFamily: "Poppins", color:Colors.white),
        styleDescription: TextStyle(fontFamily: "Poppins"),
        backgroundColor: Color(0xfff889c9),

      ),
    );
    slides.add(
      new Slide(
        title:"YOUR ID",
        description: "This is your ID! Should you choose to accept it!",
          centerWidget: TextField(
            controller: _idController,
            decoration: InputDecoration(
              labelText: "Enter UserId",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0),
                borderSide: new BorderSide(
                    color: Colors.white
                ),
              ),
              //fillColor: Colors.green
            ),
            onEditingComplete: (){
              formRandomName(_idController.text);
            },
          ),
          styleTitle: TextStyle(fontFamily: "Poppins", color:Colors.white),
          styleDescription: TextStyle(fontFamily: "Poppins"),
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
      backgroundColor: Colors.white,
      appBar: AppBar(leading: Icon(Icons.apps, color: Color(0xff4baea0),),title: Text("Anonymo", style: TextStyle(color:Color(0xff4baea0), fontFamily: "Poppins"),textAlign: TextAlign.center,),backgroundColor: Colors.white, elevation: 0.0,),
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
                title: Text("Messages", style: TextStyle(fontFamily: "Poppins", color: Color(0xff4baea0)),)

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.line_style),
                title: Text("Send", style: TextStyle(fontFamily: "Poppins", color: Color(0xff4baea0))))
          ]),
    );
  }
}

