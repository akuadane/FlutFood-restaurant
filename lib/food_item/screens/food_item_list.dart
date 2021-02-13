import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/food_item/bloc/food_item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Item> items = BlocProvider.of<FoodItemBloc>(context).state.items;
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, idx) {
          return ListTile(
            leading: Image.network(items[idx].image),
            title: Text(items[idx].name),
            subtitle: Text('\$${items[idx].price}'),
            onTap: () {
              Navigator.pushNamed(context, FoodItemDetails.routeName,
                  arguments: items[idx]);
            },
          );
        },
      ),
    );
  }
}
