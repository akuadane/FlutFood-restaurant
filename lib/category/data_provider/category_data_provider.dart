import 'dart:convert';

import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:http/http.dart';
import 'dart:async';

class CategoryDataProvider {
  final Client client;
  final String baseUrl;

  CategoryDataProvider({this.client, this.baseUrl});

  Future<List<Category>> getCategories() async {
    final Response resp = await get("${baseUrl}categories");
    if (resp.statusCode == 200) {
      final categories = jsonDecode(resp.body);
      return categories.map((c) => Category.fromJson(c)).toList();
    }
    throw Exception("Failed to load categories");
  }

  Future<Category> getCategory(int id) async {
    final Response resp = await get('${baseUrl}categories/$id');
    if (resp.statusCode == 200) {
      return Category.fromJson(jsonDecode(resp.body));
    }
    throw Exception('Failed to load category: $id');
  }

  Future<void> createCategory(Category cat) async {
    final Response resp = await post(
      '${baseUrl}categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': cat.id,
        'name': cat.name,
        'description': cat.description,
      }),
    );
    if (resp.statusCode != 201) {
      throw Exception('Failed to create category');
    }
  }

  Future<void> updateCategory(Category cat) async{
    final Response resp = await put('${baseUrl}categories/${cat.id}');
    if (resp.statusCode != 204) {
      throw Exception('Failed to update category: ${cat.id}');
    }
  }

  Future<void> deleteCategory(int id) async {
    final Response resp = await delete('${baseUrl}categories/$id');
    if (resp.statusCode != 204) {
      throw Exception('Failed to delete category: $id');
    }
  }
}
