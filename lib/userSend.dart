import 'package:anonymo/firebasedatabase.dart';
import 'package:flutter/material.dart';

class UserSend extends StatefulWidget {
  @override
  _UserSendState createState() => _UserSendState();
}

class _UserSendState extends State<UserSend> {
  FireBaseUtils _fireBaseUtils = new FireBaseUtils();
  String Username = "androidmonk1";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _fireBaseUtils.getMessage(Username),
        builder: (context, snapshot){
          if (!snapshot.hasData)
            { print("Inside no data");
              return CircularProgressIndicator();
            }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              print(snapshot.data);
              return ListTile(
                title: Text(snapshot.data[index].toString(), style: TextStyle(fontSize:25.0,color: Colors.white70),),
              );
            },
          );
        },
      ),
    );
  }
}
