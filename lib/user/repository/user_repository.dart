import 'dart:async';

import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/user/data_provider/user_provider.dart';

class UserRepository {
  final UserProvider userProvider;

  UserRepository(this.userProvider) : assert(userProvider != null);

  Future<User> getUserByUserName(String username) async {
    return this.userProvider.getUserByUserName(username);
  }
  Future<List<User>> getUsers() async {
    return this.userProvider.getUsers();
  }

  Future<User> createUser(User user) async {
    return this.userProvider.createUser(user);
  }

  Future<void> updateUser(User user) async {
    return this.userProvider.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    return this.userProvider.deleteUser(id);
  }
}
