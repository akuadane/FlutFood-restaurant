import 'dart:convert';

import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String description;

  const Category({
    this.id,
    this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class Item {
  final int id;
  final String name;
  final double price;
  final List<Category> categories;
  final String description;
  final String image;
  final List<Ingredient> ingredients;

  Item({
    this.id,
    @required this.name,
    @required this.price,
    @required this.description,
    @required this.image,
    this.categories,
    this.ingredients,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((i) => Category.fromJson(i))).toList()
          : [],
      ingredients: json['ingredients'] != null
          ? List<Ingredient>.from(
              json['ingredients'].map((i) => Ingredient.fromJson(i))).toList()
          : [],
      price: json['price'] * 1.0,
    );
  }

  Item copyWith(
      {id, name, description, image, categories, ingredients, price}) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String description;

  const Ingredient({this.id, this.name, this.description});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class User {
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String fullName;
  final String password;
  final List<Role> roles;

  User({
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.fullName,
    this.password,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['username'],
      fullName: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      roles: json['roles']?.map((r) => Role.fromJson(r))?.toList(),
    );
  }

  User copyWith({id, userName, fullName, email, phone, password, roles}) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      roles: roles ?? this.roles,
    );
  }
}

class Role {
  final int id;
  final String name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }
}
