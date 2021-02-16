import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/ingredient/data_provider/ingredient_data_provider.dart';
import 'package:flutter/foundation.dart';

class IngredientRepository {
  final IngredientDataProvider ingredientDataProvider;

  IngredientRepository({@required this.ingredientDataProvider});

  Future<List<Ingredient>> getIngredients() {
    return ingredientDataProvider.getIngredients();
  }

  Future<Ingredient> getIngredient(int id) {
    return ingredientDataProvider.getIngredient(id);
  }

  Future<void> createIngredient(Ingredient ingredient) {
    return ingredientDataProvider.createIngredient(ingredient);
  }

  Future<void> updateIngredient(Ingredient ingredient) {
    return ingredientDataProvider.updateIngredient(ingredient);
  }

  Future<void> deleteIngredient(int id) {
    return ingredientDataProvider.deleteIngredient(id);
  }
}
