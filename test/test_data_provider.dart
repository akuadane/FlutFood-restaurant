import 'dart:convert';

import 'package:http/http.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';

String baseUrl = "lot:5000";
final client = Client();

void main() async {
  final List<Item> items =
      await FoodItemDataProvider(client: client, baseUrl: baseUrl)
          .getFoodItems();
  Item item = items[1];
  final newItem = Item(
      id: item.id,
      name: item.name,
      price: item.price,
      image: 'Avatar 3',
      categories: item.categories,
      ingredients: item.ingredients,
      description: item.description);
  await FoodItemDataProvider(client: client, baseUrl: "192.168.56.1:5000")
      .updateItem(newItem);
}
