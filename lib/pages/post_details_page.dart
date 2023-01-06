import 'package:flutter/material.dart';

import '../data/data.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
    required this.post,
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(post.title)),
        body: ListView(
          children: [
            ListTile(
              title: Text(post.body),
            ),
            ListTile(
              title: const Text('userId: '),
              subtitle: Text('${post.userId}'),
            ),
            ListTile(
              title: const Text('id: '),
              subtitle: Text('${post.id}'),
            ),
          ],
        ),
      );
}
