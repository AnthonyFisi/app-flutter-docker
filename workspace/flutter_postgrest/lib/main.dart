import 'package:flutter/material.dart';
import 'package:flutter_postgrest/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostgREST Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      //TodosScreen(title:'Todos with PostgREST'),
    );
  }
}

