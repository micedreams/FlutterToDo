import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_provider.dart';
import '../components/list_widget.dart';

class PostsContent extends StatefulWidget {
  const PostsContent({Key? key}) : super(key: key);

  @override
  State createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
    
  @override
  Widget build(BuildContext context) {
    final posts = context.select((ProviderProvider p) => p.allPosts ?? []);
    return posts.isEmpty
        ? const Center(child: Text("No posts"))
        : ListWidget.buildPostList(
            context: context,
            list: posts,
          );
  }
}

