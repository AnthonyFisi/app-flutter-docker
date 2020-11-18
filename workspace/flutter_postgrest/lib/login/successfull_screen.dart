import 'package:flutter/material.dart';
import 'package:flutter_postgrest/login/Users.dart';

class SuccessfullScreen extends StatefulWidget {
  SuccessfullScreen({Key key, this.users, this.token}) : super(key: key);

  final Users users;

  final String token;

  @override
  _SuccessfullScreenState createState() => _SuccessfullScreenState();
}

class _SuccessfullScreenState extends State<SuccessfullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Successfull sign in'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Text('Welcome to PostgREST'),
              Spacer(
                flex: 1,
              ),
              Text('email'),
              Text(widget.users.email),

              Text('token'),
              Text(widget.token)
            ],
          ),
        ),
      ),
    );
  }
}
