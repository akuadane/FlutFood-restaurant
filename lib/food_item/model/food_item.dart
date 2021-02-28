// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'models.dart';
//
// class Item {
//   final int id;
//   final String name;
//   final double price;
//   final List<Category> categories;
//   final String description;
//   final String image;
//   final List<Ingredient> ingredients;
//
//   Item(
//       {this.id,
//       @required this.name,
//       @required this.price,
//       @required this.description,
//       @required this.image,
//       this.categories,
//       this.ingredients});
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       image: json['image'],
//       categories: json['categories'] != null
//           ? List<Category>.from(
//               json['categories'].map((i) => Category.fromJson(i))).toList()
//           : [],
//       ingredients: json['ingredients'] != null
//           ? List<Ingredient>.from(
//               json['ingredients'].map((i) => Ingredient.fromJson(i))).toList()
//           : [],
//       price: json['price'] * 1.0,
//     );
//   }
// }
