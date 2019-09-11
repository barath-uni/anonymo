import 'package:firebase_database/firebase_database.dart';

class FireBaseUtils
{

  final dbRef = FirebaseDatabase.instance.reference();
  void writeMessage(String username, String message)
  {
    dbRef.child(username).push().set({
      "message": message
    });
  }
  Future<List<String>> getMessage(String Username)
  async{
    print("Entering get message method");
    print(Username);
    List<String> messages = new List<String>();
    final db = dbRef.child(Username);
    await db.once().then((DataSnapshot snapshot){
    Map<dynamic, dynamic> values = snapshot.value;
    print("Inside get message");
    print(values);
    values.forEach((key, value){
    print(values[key]["message"]);
    messages.add(values[key]["message"]);
    });
    });
    return messages;
  }

  Future validateUsername(String username)
  async{
    List<String> users = new List<String>();
    await dbRef.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value){
        users.add(key);
      });
    });
    for(var key in users)
    {
      if(username == key)
        {
          return false;
        }
    }
    print("Returning True");
    return true;
  }
}