// File defines app wide settings and themes

import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/pages/home.dart';

class FlutFood extends StatefulWidget {
  @override
  _FlutFoodState createState() => _FlutFoodState();
}

class _FlutFoodState extends State<FlutFood> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
