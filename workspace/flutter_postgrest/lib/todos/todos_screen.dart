import 'package:flutter/material.dart';
import 'package:flutter_postgrest/todos/todosModel.dart';
import 'package:flutter_postgrest/todos/todosRepository.dart';
import 'package:http/http.dart' as http;

class TodosScreen extends StatefulWidget {
  TodosScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<todos>>(
              future: fetchtodosModel(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Text(snapshot.data[index].id.toString() +
                            ' - ' +
                            snapshot.data[index].task);
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Text('Loading...');
              },
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
