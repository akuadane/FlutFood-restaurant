import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/widgets/food_item_card.dart';
import 'package:flutter/material.dart';

class FoodItemDetails extends StatelessWidget {
  static const String routeName = 'food-item-details';
  final Item item;

  const FoodItemDetails({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.toUpperCase()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Row(),
          FoodItemCard(
            item: item,
          )
        ],
      ),
    );
  }
}
