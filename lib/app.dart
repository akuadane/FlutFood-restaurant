// File defines app wide settings and themes

import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/authentication/data_provider/auth_data_provider.dart';
import 'package:flut_food_restaurant/authentication/repository.auth_data_repository.dart';
import 'package:flut_food_restaurant/authentication/screens/login.dart';
import 'package:flut_food_restaurant/authentication/screens/signup.dart';
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
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/bloc/bloc.dart';
import 'package:flut_food_restaurant/order/data_provider/data_provider.dart';
import 'package:flut_food_restaurant/order/repository/order_repository.dart';
import 'package:flut_food_restaurant/role/bloc/role_bloc.dart';
import 'package:flut_food_restaurant/role/data_provider/role_data_provider.dart';
import 'package:flut_food_restaurant/role/repository/role_respository.dart';
import 'package:flut_food_restaurant/role/screens/role_list.dart';
import 'package:flut_food_restaurant/user/data_provider/user_provider.dart';
import 'package:flut_food_restaurant/user/repository/user_repository.dart';
import 'package:flut_food_restaurant/user/screens/users_list_screen.dart';
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
  final CategoryDataProvider categoryDataProvider;
  final FoodItemDataProvider foodItemDataProvider;
  final IngredientDataProvider ingredientDataProvider;
  final AuthDataProvider authDataProvider;
  final UserProvider userProvider;
  final OrderProvider orderProvider;
  final RoleDataProvider roleDataProvider;

  FlutFood({
    this.categoryDataProvider,
    this.foodItemDataProvider,
    this.ingredientDataProvider,
    this.authDataProvider,
    this.userProvider,
    this.orderProvider,
    this.roleDataProvider,
  });

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: widget.ingredientDataProvider,
        ),
        RepositoryProvider.value(
          value: widget.roleDataProvider,
        ),
        RepositoryProvider.value(
          value: widget.foodItemDataProvider,
        ),
        RepositoryProvider.value(
          value: widget.categoryDataProvider,
        ),
        RepositoryProvider.value(
          value: widget.authDataProvider,
        ),
        RepositoryProvider.value(
          value: widget.userProvider,
        ),
        RepositoryProvider.value(
          value: widget.orderProvider,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => FoodItemBloc(
                  foodItemRepository: FoodItemRepository(
                      dataProvider: widget.foodItemDataProvider))
                ..add(LoadFoodItemsEvent())),
          BlocProvider(
              create: (context) => RoleBloc(
                  roleRepository:
                      RoleRepository(roleDataProvider: widget.roleDataProvider))
                ..add(LoadRolesEvent())),
          BlocProvider(
              create: (context) =>
                  OrderBloc(OrderRepository(widget.orderProvider))
                    ..add(OrderLoad())),
          BlocProvider(
              create: (context) => IngredientBloc(
                  ingredientRepository: IngredientRepository(
                      ingredientDataProvider: widget.ingredientDataProvider))
                ..add(LoadIngredientsEvent())),
          BlocProvider(
              create: (context) => CategoryBloc(
                  categoryRepository: CategoryRepository(
                      categoryDataProvider: widget.categoryDataProvider))
                ..add(LoadCategoriesEvent())),
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authRepository:
                      AuthDataRepository(dataProvider: widget.authDataProvider),
                  userRepository: UserRepository(widget.userProvider))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepOrange,
          ),
          onGenerateRoute: _ongenerateRoute,
          initialRoute: "/login",
          routes: {
            '/users': (context) => UsersListScreen(),
            '/roles': (context) => RoleListScreen(),
            SignupPage.routeName: (context) => SignupPage(),
            FoodItemDetails.routeName: (context) => FoodItemDetails(),
            AddUpdateFoodItem.routeName: (context) => AddUpdateFoodItem(),
          },
        ),
      ),
    );
  }

  PageRoute _ongenerateRoute(RouteSettings settings) {
    if (settings.name == "/login") {
      return MaterialPageRoute(builder: (ctx) => LoginPage());
    } else if (settings.name == Home.routeName) {
      final User user = settings.arguments;
      return MaterialPageRoute(
        builder: (ctx) => Home(
          user: user,
        ),
      );
    }
  }
}
