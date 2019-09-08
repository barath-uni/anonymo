
class UserMessageModel
{
  String username;
  String message;

  UserMessageModel(this.username, this.message);


  toJson() {
    return {
      "message": message,
      "username": username
    };
  }
}