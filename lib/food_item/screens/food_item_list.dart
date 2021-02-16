import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flut_food_restaurant/food_item/bloc/food_item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemList extends StatelessWidget {
  static const String routeName = 'food-item-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FoodItemBloc, FoodItemState>(
        builder: (BuildContext context, state) {
          if (state is FoodItemLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                CircularProgressIndicator(),
              ],
            );
          }
          if (state is FoodItemsLoadFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                Text('Failed to load food items'),
              ],
            );
          }
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (ctx, idx) {
              return ListTile(
                leading: Image.network(state.items[idx].image, width: 100.0, fit: BoxFit.cover,),
                title: Text(state.items[idx].name),
                subtitle: Text('\$${state.items[idx].price}'),
                onTap: () {
                  Navigator.pushNamed(context, FoodItemDetails.routeName,
                      arguments: state.items[idx]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
