import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_postgrest/login/JwtToken.dart';
import 'package:http/http.dart' as http;
import 'Users.dart';

Future<List<JwtToken>> login(http.Client client, Users users) async {
  //Use ngrok to exposed your endpoint /todos or ip address;
  String url = 'http://192.168.1.132:3000/rpc/login';

  final response = await client.post(url,
      headers: {"content-type": "application/json"},
      body: Users.UsersToJson(users));

  print(Users.UsersToJson(users));
  print(response.body);

  if (response.statusCode == 200) {
    return compute(parseJwtTokenModel, response.body);
  } else {
    throw Exception('Failed to sign in');
  }
}

List<JwtToken> parseJwtTokenModel(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<JwtToken>((json) => JwtToken.fromJson(json)).toList();
}
