import 'package:coding_interview/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Post>> getPosts() async {
  var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
  final response = await http.get(url);
  final list = <Post>[];
  final responsejson = jsonDecode(response.body);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('posts', response.body);

  for (var post in responsejson) {
    list.add(Post.fromJson(post));
  }

  return list;
}

Future<Post> getPost(int id) async {
  final url = Uri.https('jsonplaceholder.typicode.com', 'posts/$id');
  final response = await http.get(url);
  final post = Post.fromJson(jsonDecode(response.body));

  return post;
}

Future<Post> getCommentsForPost(Post post) async {
  throw UnimplementedError();
}
