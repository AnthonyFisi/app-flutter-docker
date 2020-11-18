import 'dart:convert';

class Users {
  final String email;
  final String pass;


  Users({this.email, this.pass});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        email: json['email'] as String,
        pass: json['pass'] as String);
  }

  Map<String,dynamic> toJson(){
    return{
      "email": email,
      "pass": pass,
    };
  }

  static String UsersToJson(Users users) {
    final jsonData = users.toJson();
    return json.encode(jsonData);
  }

}


