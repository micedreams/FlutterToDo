import 'package:coding_interview/provider_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/list_widget.dart';

class UserContent extends StatefulWidget {
  const UserContent({Key? key}) : super(key: key);

  @override
  State createState() => _UserContentState();
}

class _UserContentState extends State<UserContent> {
  @override
  Widget build(BuildContext context) {
    final users = context.select((ProviderProvider p) => p.allUsers ?? []);

    return users.isEmpty
        ? const Center(child: Text("No users"))
        : ListWidget.buildUserList(
            context: context,
            list: users,
          );
  }
}
