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
          AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.network(item.image),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.name),
                SizedBox(height: 8.0),
                Text('\$${item.price}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
