// File defines app wide settings and themes

import 'package:flut_food_restaurant/category/bloc/category_bloc.dart';
import 'package:flut_food_restaurant/category/data_provider/category_data_provider.dart';
import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';
import 'package:flut_food_restaurant/ingredient/bloc/ingredient_bloc.dart';
import 'package:flut_food_restaurant/ingredient/data_provider/ingredient_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'food_item/bloc/food_item_bloc.dart';

class FlutFood extends StatefulWidget {
  @override
  _FlutFoodState createState() => _FlutFoodState();
}

class _FlutFoodState extends State<FlutFood> {
  final FoodItemDataProvider foodItemDataProvider = FoodItemDataProvider(
      client: Client(),
      baseUrl: 'https://dry-wildwood-77069.herokuapp.com/v1/admin/');
  final IngredientDataProvider ingredientDataProvider = IngredientDataProvider(
      client: Client(),
      baseUrl: 'https://dry-wildwood-77069.herokuapp.com/v1/admin/');
  final CategoryDataProvider categoryDataProvider = CategoryDataProvider(
      client: Client(),
      baseUrl: 'https://dry-wildwood-77069.herokuapp.com/v1/admin/');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FoodItemBloc()),
        BlocProvider(create: (context) => IngredientBloc()),
        BlocProvider(create: (context) => CategoryBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
        ),
        home: Home(),
      ),
    );
  }
}

