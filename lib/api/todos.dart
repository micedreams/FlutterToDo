import 'package:coding_interview/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ToDo>> getTodos() async {
  final url = Uri.https('jsonplaceholder.typicode.com', 'todos');
  final response = await http.get(url);
  final list = <ToDo>[];
  final responsejson = jsonDecode(response.body);

  for (var todo in responsejson) {
    list.add(ToDo.fromJson(todo));
  }

  return list;
}

Future<ToDo> getTodo(int id) async {
  final url = Uri.https('jsonplaceholder.typicode.com', 'todos/$id');
  final response = await http.get(url);
  final todo = 200 == response.statusCode
      ? ToDo.fromJson(jsonDecode(response.body))
      : ToDo(
          id: id,
          userId: 0,
          title: "Todo no.$id",
          completed: false,
        );

  return todo;
}

Future<List<ToDo>> getTodosForUser(User user) async {
  throw UnimplementedError();
}
