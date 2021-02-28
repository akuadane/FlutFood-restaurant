import 'dart:convert';

import 'package:flut_food_restaurant/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataProvider {
  final SharedPreferences preferences;

  AuthDataProvider({this.preferences});

  Future<bool> storeUser(User user) async {
    try {
      await preferences.setString("user", jsonEncode(user.toJson(user)));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  User getUser() {
    final data = preferences.getString("user");
    return User.fromJson(jsonDecode(data));
  }

  Future<bool> deleteUser() async {
    try {
      await preferences.remove("user");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
