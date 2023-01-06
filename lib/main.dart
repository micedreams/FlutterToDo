import 'dart:convert';

import 'package:coding_interview/api/todos.dart';
import 'package:coding_interview/api/users.dart';
import 'package:coding_interview/pages/posts_page.dart';
import 'package:coding_interview/pages/todos_page.dart';
import 'package:coding_interview/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/post.dart';
import 'data/data.dart';
import 'components/list_items_search_delegate.dart';
import 'provider_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<ToDo> allToDos = [];
  List<Post> allPosts = [];
  List<User> allUsers = [];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? posts = prefs.getString('post');

  await getTodos().then((todos) {
    allToDos = todos;
  });

  if (null == posts) {
    await getPosts().then((posts) {
      allPosts = posts;
    });
  } else {
    for (var post in jsonDecode(posts)) {
      allPosts.add(Post.fromJson(post));
    }
  }

  await getUsers().then((users) {
    allUsers = users;
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProviderProvider(
                  allToDos,
                  allPosts,
                  allUsers,
                ))
      ],
      child: (allToDos.isEmpty && allPosts.isEmpty && allUsers.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const MainPage(title: 'Amazing Todo App'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final pages = const [TodoContent(), PostsContent(), UserContent()];

  @override
  Widget build(BuildContext context) {
    final allToDos = context.select((ProviderProvider p) => p.allToDos ?? []);

    return Scaffold(
      floatingActionButton: 0 == _currentIndex
          ? FloatingActionButton(
            backgroundColor: Colors.amber[800],
              onPressed: () {
                final updatedlist = <ToDo>[];
                updatedlist.add(ToDo(
                  id: allToDos.length,
                  userId: 0,
                  title: "Todo no.${allToDos.length}",
                  completed: false,
                ));
                updatedlist.addAll(allToDos);
                
                Provider.of<ProviderProvider>(context, listen: false)
                    .updateToDos(updatedlist);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: ListItemsSearchDelegate(
                  currentIndex: _currentIndex,
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Users',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
