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
    List<String> messages = new List<String>();
    final db = dbRef.child(Username);
    await db.once().then((DataSnapshot snapshot){
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, value){
    print(values[key]["message"]);
    messages.add(values[key]["message"]);
    });
    });
    return messages;
  }
}