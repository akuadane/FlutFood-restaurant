import 'package:flut_food_restaurant/category/data_provider/category_data_provider.dart';
import 'dart:async';

import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart' as md;

class CategoryRepository {
  final CategoryDataProvider categoryDataProvider;

  CategoryRepository({@required this.categoryDataProvider});

  Future<List<md.Category>> getCategories() {
    return categoryDataProvider.getCategories();
  }

  Future<md.Category> getCategory(int id) {
    return categoryDataProvider.getCategory(id);
  }

  Future<void> updateCategory(md.Category cat) {
    return categoryDataProvider.updateCategory(cat);
  }

  Future<void> createCategory(md.Category cat) {
    return categoryDataProvider.createCategory(cat);
  }

  Future<void> deleteCategory(int id) {
    return categoryDataProvider.deleteCategory(id);
  }
}
