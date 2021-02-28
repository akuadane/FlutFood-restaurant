import 'dart:convert';

import 'package:flut_food_restaurant/api_config_files.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:http/http.dart';

class UserProvider {
  final Client httpClient;

  UserProvider(this.httpClient) : assert(httpClient != null);

  Future<List<User>> getUsers() async {
    final response = await httpClient.get(Uri.http(baseUrl, "v1/admin/users"),
        headers: {'api-key': adminApiKey});
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      return users.map((u) => User.fromJson(u)).toList();
    }
    throw Exception("Error fetching users");
  }

  Future<User> getUserByUserName(String username) async {
    final response = await this.httpClient.get(
      Uri.http(baseUrl, "/v1/admin/username/$username"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'api-key': adminApiKey
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error fetching user");
  }

  Future<User> createUser(User user) async {
    final response = await httpClient.post(
      Uri.http(baseUrl, "/v1/admin/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'api-key': adminApiKey
      },
      body: jsonEncode(<String, dynamic>{
        "username": user.userName,
        "email": user.email,
        "fullname": user.fullName,
        "phone": user.phone,
        "password": user.password,
        "roles": user.roles
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(user.userName);
      return getUserByUserName(user.userName);
    }
    throw Exception("Error creating user");
  }

  Future<void> updateUser(User user) async {
    final response = await httpClient.put(
          Uri.http(baseUrl, "v1/admin/users/${user.id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'api-key': adminApiKey
          },
          body: jsonEncode(<String, dynamic>{
            "id": user.id,
            "username": user.userName,
            "email": user.email,
            "fullname": user.fullName,
            "phone": user.phone,
            "password": user.password,
            "roles": user.roles,
          }),
        );
    print(response.statusCode);
    if (response.statusCode != 200) throw Exception("Error updating user data");
  }

  Future<void> deleteUser(int id) async {
    final response = await this.httpClient.delete(
      Uri.http(baseUrl, "v1/admin/users/$id"),
      headers: <String, String>{'api-key': adminApiKey},
    );

    if (response.statusCode != 204) {
      throw Exception("Error deleting user");
    }
  }
}
