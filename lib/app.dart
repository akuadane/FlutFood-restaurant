// File defines app wide settings and themes

import 'package:flut_food_restaurant/category/bloc/category_bloc.dart';
import 'package:flut_food_restaurant/category/data_provider/category_data_provider.dart';
import 'package:flut_food_restaurant/category/repository/category_respository.dart';
import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';
import 'package:flut_food_restaurant/food_item/repository/food_item_repository.dart';
import 'package:flut_food_restaurant/food_item/screens/add_update_food_item.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_details.dart';
import 'package:flut_food_restaurant/ingredient/bloc/ingredient_bloc.dart';
import 'package:flut_food_restaurant/ingredient/data_provider/ingredient_data_provider.dart';
import 'package:flut_food_restaurant/ingredient/repository/ingredient_repository.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flut_food_restaurant/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'amplifyconfiguration.dart';
import 'food_item/bloc/food_item_bloc.dart';

const ipAddress = '192.168.137.1:5000';

class FlutFood extends StatefulWidget {
  static const String baseUrl = "192.168.137.1:5000";
  final FoodItemDataProvider foodItemDataProvider =
      FoodItemDataProvider(client: Client(), baseUrl: baseUrl);
  final IngredientDataProvider ingredientDataProvider =
      IngredientDataProvider(client: Client(), baseUrl: baseUrl);
  final CategoryDataProvider categoryDataProvider =
      CategoryDataProvider(client: Client(), baseUrl: baseUrl);

  @override
  _FlutFoodState createState() => _FlutFoodState();
}

class _FlutFoodState extends State<FlutFood> {
  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    // AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 storageS3 = AmplifyStorageS3();
    Amplify.addPlugins([storageS3]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FoodItemBloc(
                foodItemRepository: FoodItemRepository(
                    dataProvider: widget.foodItemDataProvider))
              ..add(LoadFoodItemsEvent())),
        BlocProvider(
            create: (context) => IngredientBloc(
                ingredientRepository: IngredientRepository(
                    ingredientDataProvider: widget.ingredientDataProvider))
              ..add(LoadIngredientsEvent())),
        BlocProvider(
            create: (context) => CategoryBloc(
                categoryRepository: CategoryRepository(
                    categoryDataProvider: widget.categoryDataProvider))
              ..add(LoadCategoriesEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
        ),
        home: Home(),
        routes: {
          FoodItemDetails.routeName: (context) => FoodItemDetails(),
          AddUpdateFoodItem.routeName: (context) => AddUpdateFoodItem(),
        },
      ),
    );
  }
}
