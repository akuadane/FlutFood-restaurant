import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flutter/cupertino.dart';

class FoodItemRepository {
  final FoodItemDataProvider dataProvider;

  FoodItemRepository({@required this.dataProvider});

  Future<List<Item>> getFoodItems() {
    return dataProvider.getFoodItems();
  }

  Future<void> createItem(Item item) {
    return dataProvider.createItem(item);
  }

  Future<Item> getFoodItem(int id) {
    return dataProvider.getFoodItem(id);
  }

  Future<void> updateItem(Item item) {
    return dataProvider.updateItem(item);
  }

  Future<void> deleteItem(int id) {
    return dataProvider.deleteFoodItem(id);
  }
}
