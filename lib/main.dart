import 'package:flut_food_restaurant/authentication/data_provider/auth_data_provider.dart';
import 'package:flut_food_restaurant/authentication/repository.auth_data_repository.dart';
import 'package:flut_food_restaurant/flut_food_observer.dart';
import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';
import 'package:flut_food_restaurant/ingredient/data_provider/ingredient_data_provider.dart';
import 'package:flut_food_restaurant/order/data_provider/data_provider.dart';
import 'package:flut_food_restaurant/role/data_provider/role_data_provider.dart';
import 'package:flut_food_restaurant/user/data_provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/category/data_provider/category_data_provider.dart';
import 'package:flut_food_restaurant/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config_files.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  Client client = Client();
  final OrderProvider orderProvider = OrderProvider(client);
  final RoleDataProvider roleDataProvider = RoleDataProvider(client: client, baseUrl: baseUrl);

  final AuthDataProvider authDataProvider =
      AuthDataProvider(preferences: sharedPrefs);
  final CategoryDataProvider categoryDataProvider =
      CategoryDataProvider(client: client, baseUrl: baseUrl);
  final IngredientDataProvider ingredientDataProvider =
      IngredientDataProvider(client: client, baseUrl: baseUrl);
  final FoodItemDataProvider foodItemDataProvider =
      FoodItemDataProvider(client: client, baseUrl: baseUrl);
  final UserProvider userProvider = UserProvider(client);
  Bloc.observer = FlutFoodObserver();
  runApp(FlutFood(
    roleDataProvider: roleDataProvider,
    userProvider: userProvider,
    foodItemDataProvider: foodItemDataProvider,
    ingredientDataProvider: ingredientDataProvider,
    categoryDataProvider: categoryDataProvider,
    authDataProvider: authDataProvider,
    orderProvider: orderProvider,
  ));
}
