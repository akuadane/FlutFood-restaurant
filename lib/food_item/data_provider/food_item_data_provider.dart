import 'dart:convert';

import 'package:flut_food_restaurant/api_config_files.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:http/http.dart';

class FoodItemDataProvider {
  final Client client;
  final baseUrl;

  FoodItemDataProvider({this.client, this.baseUrl})
      : assert(client != null),
        assert(baseUrl != null);

  Future<List<Item>> getFoodItems() async {
    final Response resp =
        await client.get(Uri.http(baseUrl, '/v1/admin/items'), headers: <String, String> {'api-key': adminApiKey});
    if (resp.statusCode == 200) {
      final items = jsonDecode(resp.body) as List;
      return items.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception(
          'Failed to load food items status code: ${resp.statusCode}');
    }
  }

  Future<Item> getFoodItem(int id) async {
    final Response resp =
        await client.get(Uri.http(baseUrl, '/v1/admin/items/$id'),headers: <String, String> {'api-key': adminApiKey});
    if (resp.statusCode == 200) {
      final item = jsonDecode(resp.body);
      return Item.fromJson(item);
    } else {
      throw Exception("Failed to load food item: $id");
    }
  }

  Future<void> deleteFoodItem(int id) async {
    final Response resp =
        await client.delete(Uri.http(baseUrl, '/v1/admin/items/$id'), headers: <String, String> {'api-key': adminApiKey});
    if (resp.statusCode != 204) {
      throw Exception("Failed to delete food item: $id");
    }
  }

  Future<void> updateItem(Item item) async {
    final Response resp = await client.put(
        Uri.http(baseUrl, '/v1/admin/items/${item.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'api-key': adminApiKey
        },
        body: jsonEncode(<String, dynamic>{
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'description': item.description,
          'image': item.image,
          'ingredients': item.ingredients,
          'categories': item.categories,
        }));
    if (resp.statusCode != 200) {
      print(resp.statusCode);
      throw Exception("Failed to update item: ${item.id}");
    }
  }

  Future<void> createItem(Item item) async {
    final Response resp = await client.post(
      Uri.http(baseUrl, '/v1/admin/items'),
      headers: <String, String>{
        'api-key': adminApiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': item.id,
        'name': item.name,
        'price': item.price,
        'description': item.description,
        'image': item.image,
        'ingredients': item.ingredients,
        'categories': item.categories,
      }),
    );
    if (resp.statusCode != 201) {
      throw Exception("Failed to create item");
    }
  }
}
