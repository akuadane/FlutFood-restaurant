import 'dart:convert';

import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:http/http.dart';

class IngredientDataProvider {
  final Client client;
  final baseUrl;

  IngredientDataProvider({this.client, this.baseUrl})
      : assert(client != null),
        assert(baseUrl != null);

  Future<List<Ingredient>> getIngredients() async {
    final Response resp = await client
        .get(await client.get(Uri.http(baseUrl, '/v1/admin/ingredients')));
    if (resp.statusCode == 200) {
      final ingredients = jsonDecode(resp.body) as List;
      return ingredients.map((e) => Ingredient.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load food ingredients');
    }
  }

  Future<Ingredient> getIngredient(int id) async {
    final Response resp = await client.get("${baseUrl}ingredients/$id");
    if (resp.statusCode == 200) {
      final ingredient = jsonDecode(resp.body);
      return Ingredient.fromJson(ingredient);
    } else {
      throw Exception("Failed to load food ingredients: $id");
    }
  }

  Future<void> deleteIngredient(int id) async {
    final Response resp = await client.delete('${baseUrl}ingredients/$id');
    if (resp.statusCode != 204) {
      throw Exception("Failed to delete food ingredient: $id");
    }
  }

  Future<void> updateIngredient(Ingredient ingredient) async {
    final Response resp = await client.put(
        '${baseUrl}ingredients/${ingredient.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8;',
        },
        body: <String, dynamic>{
          'id': ingredient.id,
          'name': ingredient.name,
          'description': ingredient.description,
        });
    if (resp.statusCode != 201) {
      throw Exception("Failed to update ingredient: ${ingredient.id}");
    }
  }

  Future<void> createIngredient(Ingredient ingredients) async {
    final Response resp = await client.post(
      '${baseUrl}ingredients',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': ingredients.id,
        'name': ingredients.name,
        'description': ingredients.description,
      }),
    );
    if (resp.statusCode != 201) {
      throw Exception("Failed to create ingredient");
    }
  }
}
