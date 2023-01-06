import 'package:coding_interview/data/data.dart';
import 'package:flutter/material.dart';

import '../api/post.dart';
import '../api/todos.dart';
import '../pages/post_details_page.dart';
import '../pages/todo_details_page.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
    required this.list,
    required this.onTap,
    required this.buildText,
  }) : super(key: key);

  final List list;
  final ValueChanged onTap;
  final Function buildText;

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            onTap(list[index].id);
          },
          title: Text(buildText(list[index])),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );

  factory ListWidget.buildTodoList({
    required BuildContext context,
    required List<ToDo> list,
  }) {
    return ListWidget(
      list: list,
      buildText: (todo) {
        return todo.title;
      },
      onTap: (todoId) async {
        final todoDetails = await getTodo(todoId);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TodoDetails(todo: todoDetails),
        ));
      },
    );
  }

  factory ListWidget.buildPostList({
    required BuildContext context,
    required List<Post> list,
  }) {
    return ListWidget(
      list: list,
      buildText: (post) {
        return post.title;
      },
      onTap: (postId) async {
        final postDetails = await getPost(postId);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostDetails(post: postDetails),
        ));
      },
    );
  }

  factory ListWidget.buildUserList({
    required BuildContext context,
    required List<User> list,
  }) {
    return ListWidget(
      list: list,
      buildText: (user) {
        return user.name;
      },
      onTap: (userId) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('User id: $userId'),
          ),
        );
      },
    );
  }
}
