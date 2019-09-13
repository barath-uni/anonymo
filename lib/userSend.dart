import 'package:anonymo/UserIdDB.dart';
import 'package:anonymo/firebasedatabase.dart';
import 'package:flutter/material.dart';

class UserSend extends StatefulWidget {
  @override
  _UserSendState createState() => _UserSendState();
}

class _UserSendState extends State<UserSend> {
  FireBaseUtils _fireBaseUtils = new FireBaseUtils();
  String Username;
  UserIdDb _userIdDb = UserIdDb();


  void getUserName()
  async{
    print("Object of user id db");
    print(_userIdDb);
    var username = await _userIdDb.retrieveUserId();
    setState(() {
      Username = username;
    });
  }

  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder(
        future: _fireBaseUtils.getMessage(Username),
        builder: (context, snapshot){
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
          if(snapshot.connectionState == ConnectionState.done) {
            print("Data is");
            print(snapshot.data);
            if(snapshot.data != null)
              {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index){
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        boxShadow: [
                        BoxShadow(
                        color: Color(0xffb6e6bd),
                        blurRadius: 5.0, // has the effect of softening the shadow
                        spreadRadius: 1.0, // has the effect of extending the shadow
                        offset: Offset(
                          2.0, // horizontal, move right 10
                          2.0, // vertical, move down 10
                        ),
                      )
                      ],
                      ),
                      child: ListTile(
                        leading: Icon(Icons.call_received, color: Color(0xfff88379), size: 14.0,),
                        isThreeLine: true,
                        title: Text(snapshot.data[index].toString(),
                          style: TextStyle(fontFamily: 'Poppins',
                              fontSize: 15.0,
                              color:Color(0xff4baea0)),),
                        subtitle: Column(
                          children: <Widget>[
                            Text("Message Received Recently",
                                style: TextStyle(fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color:Color(0xffb6e6bd))),
                            Icon(Icons.linear_scale, size: 30.0, color:Color(0xfff88379))
                          ],
                        ),

                      ),
                    );
                  },
                );
              }
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
