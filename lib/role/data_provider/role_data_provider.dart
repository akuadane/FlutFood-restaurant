import 'dart:convert';

import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:http/http.dart';
import 'dart:async';

class RoleDataProvider {
  final Client client;
  final String baseUrl;

  RoleDataProvider({this.client, this.baseUrl});

  Future<List<Role>> getRoles() async {
    final Response resp = await client.get(Uri.http(baseUrl, "v1/admin/roles"));
    if (resp.statusCode == 200) {
      final roles = jsonDecode(resp.body) as List;
      print(roles);
      return roles.map((c) => Role.fromJson(c)).toList();
    }
    throw Exception("Failed to load roles");
  }

  Future<Role> getRole(int id) async {
    final Response resp = await client.get(Uri.http(baseUrl, "v1/admin/roles"));
    if (resp.statusCode == 200) {
      return Role.fromJson(jsonDecode(resp.body));
    }
    throw Exception('Failed to load role: $id');
  }

  Future<void> createRole(Role cat) async {
    final Response resp = await client.post(
      Uri.http(baseUrl, 'v1/admin/roles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': cat.id,
        'name': cat.name,
      }),
    );
    if (resp.statusCode != 201) {
      throw Exception('Failed to create role');
    }
  }

  Future<void> updateRole(Role cat) async {
    final Response resp = await client.put(Uri.http(baseUrl, 'v1/admin/roles/${cat.id}'));
    if (resp.statusCode != 204) {
      throw Exception('Failed to update role: ${cat.id}');
    }
  }

  Future<void> deleteRole(int id) async {
    final Response resp = await delete(Uri.http(baseUrl, 'v1/admin/roles/$id'));
    if (resp.statusCode != 204) {
      throw Exception('Failed to delete role: $id');
    }
  }
}
