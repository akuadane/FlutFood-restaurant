import 'dart:convert';

import 'package:flut_food_restaurant/category/bloc/category_bloc.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/ingredient/bloc/ingredient_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateFoodItem extends StatefulWidget {
  final Item item;
  final bool edit;

  AddUpdateFoodItem({this.edit = false, this.item});

  @override
  _AddUpdateFoodItemState createState() => _AddUpdateFoodItemState();
}

class _AddUpdateFoodItemState extends State<AddUpdateFoodItem> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _item = {};
  CategoryBloc categoryBloc;
  IngredientBloc ingredientBloc;

  @override
  Widget build(BuildContext context) {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? 'Update Item' : "Add Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.edit ? widget.item.name : '',
                decoration: InputDecoration(
                    hintText: 'Enter item name', border: OutlineInputBorder()),
                onSaved: (value) {
                  setState(() {
                    _item['name'] = value;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: widget.edit ? widget.item.price: '',
                decoration: InputDecoration(
                    hintText: 'Enter item price', border: OutlineInputBorder()),
                onSaved: (value) {
                  _item['price'] = double.parse(value);
                },
              ),
              TextFormField(
                initialValue: widget.edit ? widget.item.description : '',
                decoration: InputDecoration(
                    hintText: 'Enter item description',
                    border: OutlineInputBorder()),
                onSaved: (value) {
                  _item['description'] = value;
                },
              ),
              DropdownButtonFormField<Category>(
                items: categoryBloc.state.categories
                    .map((c) => DropdownMenuItem<Category>(
                          value: c,
                          child: Text('${c.name}'),
                        ))
                    .toList(),
                onChanged: (c) {},
                onSaved: (Category c) {
                  _item['categories'] = jsonEncode([c]);
                },
              ),
              DropdownButtonFormField<Ingredient>(
                items: ingredientBloc.state.ingredients.map(
                  (e) => DropdownMenuItem<Ingredient>(
                    value: e,
                    child: Text(e.name),
                  ),
                ),
                onChanged: (i) {},
                onSaved: (Ingredient i) {
                  _item['ingredients'] = jsonEncode([i]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ingredientBloc?.close();
    categoryBloc?.close();
    super.dispose();
  }
}
