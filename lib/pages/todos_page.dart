import 'package:coding_interview/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/todos.dart';
import '../provider_provider.dart';
import '../components/list_widget.dart';

class TodoContent extends StatefulWidget {
  const TodoContent({Key? key}) : super(key: key);

  @override
  State createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  @override
  Widget build(BuildContext context) {
    final todos = context.select((ProviderProvider p) => p.allToDos ?? []);

    return todos.isEmpty
        ? const Center(child: Text("No todos"))
        : ListWidget.buildTodoList(
            context: context,
            list: todos,
          );
  }
}
