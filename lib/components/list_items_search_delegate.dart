import 'package:coding_interview/provider_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import 'list_widget.dart';

class ListItemsSearchDelegate extends SearchDelegate {
  ListItemsSearchDelegate({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final allToDos = context.select((ProviderProvider p) => p.allToDos ?? []);
    final allPosts = context.select((ProviderProvider p) => p.allPosts ?? []);
    final allUsers = context.select((ProviderProvider p) => p.allUsers ?? []);

    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    if (0 == currentIndex) {
      final searchResults = allToDos
          .where((listItem) =>
              listItem.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return searchResults.isEmpty
          ? const Center(child: Text("No todos"))
          : ListWidget.buildTodoList(
              context: context,
              list: searchResults,
            );
    } else if (1 == currentIndex) {
      final searchResults = allPosts
          .where((listItem) =>
              listItem.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return searchResults.isEmpty
          ? const Center(child: Text("No posts"))
          : ListWidget.buildPostList(
              context: context,
              list: searchResults,
            );
    } else if (2 == currentIndex) {
      final searchResults = allUsers
          .where((listItem) =>
              listItem.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return searchResults.isEmpty
          ? const Center(child: Text("No users"))
          : ListWidget.buildUserList(
              context: context,
              list: searchResults,
            );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
