import 'package:flutter/foundation.dart';

import 'data/data.dart';

class ProviderProvider with ChangeNotifier {
  List<ToDo>? allToDos;
  List<Post>? allPosts;
  List<User>? allUsers;

  ProviderProvider(
    this.allToDos,
    this.allPosts,
    this.allUsers,
  );

  void updateToDos(List<ToDo> updatedTodos) {
    allToDos = updatedTodos;
    notifyListeners();
  }

  void updatePosts(List<Post> updatedPosts) {
    allPosts = updatedPosts;
    notifyListeners();
  }

  void updateUsers(List<User> updatedUsers) {
    allUsers = updatedUsers;
    notifyListeners();
  }
}
