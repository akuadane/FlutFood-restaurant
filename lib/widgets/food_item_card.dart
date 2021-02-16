import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flutter/material.dart';

class FoodItemCard extends StatelessWidget {
  final Item item;

  const FoodItemCard({this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(),
          Image.network(item.image, height: 250.0, width: double.infinity, fit: BoxFit.cover,),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.name),
                SizedBox(height: 8.0),
                Text('\$${item.price}'),
                SizedBox(height: 8.0),
                Text(item.description)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
