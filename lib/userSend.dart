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
          print("Inside showing data");
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
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    return ListTile(
                      title: Text(snapshot.data[index].toString(),
                        style: TextStyle(fontSize: 25.0, color: Colors.white70),),
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
