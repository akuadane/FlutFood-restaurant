import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/screens/order_list_screen.dart';
import 'package:flut_food_restaurant/order/screens/screens.dart';

class OrderRoutes {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == OrderListScreen.routeName) {
      return MaterialPageRoute(builder: (context) => OrderListScreen());
    } else if (settings.name == OrderAddScreen.routeName) {
      return MaterialPageRoute(builder: (context) => OrderAddScreen());
    } else if (settings.name == OrderDetailScreen.routeName) {
      Order order = settings.arguments;
      return MaterialPageRoute(builder: (context) => OrderDetailScreen(order));
    } else if (settings.name == OrderUpdateScreen.routeName) {
      Order order = settings.arguments;
      return MaterialPageRoute(builder: (context) => OrderUpdateScreen(order));
    }

    return MaterialPageRoute(builder: (context) => OrderListScreen());
  }
}
