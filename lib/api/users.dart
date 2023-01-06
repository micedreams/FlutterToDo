import 'package:coding_interview/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<User>> getUsers() async {
  final url = Uri.https('jsonplaceholder.typicode.com', 'users');
  final response = await http.get(url);
  final list = <User>[];
  final responsejson = jsonDecode(response.body);

  for (var user in responsejson) {
    list.add(User.fromJson(user));
  }

  return list;
}

Future<User> getUser(int id) async {
  throw UnimplementedError();
}
