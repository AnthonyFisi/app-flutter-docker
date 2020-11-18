import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_postgrest/todos/todosModel.dart';
import 'package:http/http.dart' as http;

  Future<List<todos>> fetchtodosModel(http.Client client) async {
    //Use ngrok to expose your endpoint /todos or ip address;
    String url = 'http://localhost:3000/todos';

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(parsetodosModel, response.body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  List<todos> parsetodosModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<todos>((json) => todos.fromJson(json)).toList();
  }

