import 'package:flutfood_restaurant/screens/login.dart';
import 'package:flutter/material.dart';

class FlutFoodRestaurant extends StatefulWidget {
  @override
  _FlutFoodState createState() => _FlutFoodState();
}

class _FlutFoodState extends State<FlutFoodRestaurant> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
