import 'package:anonymo/firebasedatabase.dart';
import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _userController = new TextEditingController();

  FireBaseUtils _fireBaseUtils = new FireBaseUtils();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[

            Container(
              child: TextField(
          cursorColor: Colors.black,
          cursorWidth: 10.0,
          decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle),
              fillColor: Colors.white70
          ),
          controller: _userController,
        ),
        color: Colors.white,
      ),
            Spacer(),
            Container(
              child:TextField(
                cursorColor: Colors.black,
                cursorWidth: 10.0,
                decoration: InputDecoration(
                    icon: Icon(Icons.message),
                    fillColor: Colors.white70
                ),
                controller: _controller,
              ),
              color: Colors.white,
            ),
            Spacer(),
            FlatButton(
              color: Colors.white,
              child: Text("Send Feedback"),
              onPressed: (){
                _fireBaseUtils.writeMessage(_userController.text, _controller.text);
              },
            ),
            Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }
}
