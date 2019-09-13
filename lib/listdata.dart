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
          cursorWidth: 2.0,
          decoration: InputDecoration(
          labelText: "Enter UserId",
          fillColor: Colors.white,
          icon: Icon(Icons.supervised_user_circle),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: new BorderSide(
            ),
          ),
          //fillColor: Colors.green
        ),
        style: TextStyle(fontFamily: "Poppins", color: Color(0xff4baea0), fontSize: 12.0),
          controller: _userController,
        ),
        color: Colors.white,
      ),
            Spacer(),
            Container(
              child:TextField(
                cursorColor: Colors.black,
                cursorWidth: 2.0,
                decoration: InputDecoration(
                  labelText: "Enter Message",
                  icon: Icon(Icons.message),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                style: TextStyle(fontFamily: "Poppins", color: Color(0xff4baea0), fontSize: 12.0),
                controller: _controller,
              ),
              color: Colors.white,
            ),
            Spacer(),
            FlatButton(
              color: Color(0xff4baea0),
              child: Text("Send Feedback",
                style: TextStyle(fontFamily: "Poppins",
                    color: Colors.white, fontSize: 14.0),),
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
