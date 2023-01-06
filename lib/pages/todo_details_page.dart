import 'package:flutter/material.dart';

import '../data/data.dart';

class TodoDetails extends StatelessWidget {
  const TodoDetails({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final ToDo todo;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(todo.title)),
        body: ListView(
          children: [
            ListTile(
              title: const Text('completed: '),
              subtitle: Text('${todo.completed}'),
            ),
            ListTile(
              title: const Text('userId: '),
              subtitle: Text('${todo.userId}'),
            ),
            ListTile(
              title: const Text('id: '),
              subtitle: Text('${todo.id}'),
            ),
          ],
        ),
      );
}
