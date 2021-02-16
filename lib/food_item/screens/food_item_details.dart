import 'package:flut_food_restaurant/food_item/bloc/bloc.dart';
import 'package:flut_food_restaurant/food_item/model/add_update_screen_arguments.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/screens/add_update_food_item.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_list.dart';
import 'package:flut_food_restaurant/widgets/food_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemDetails extends StatelessWidget {
  static const String routeName = 'food-item-details';

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;
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
            onPressed: () {
              Navigator.pushNamed(context, AddUpdateFoodItem.routeName,
                  arguments: AddUpdateScreenArgument(item: item, edit: true));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<FoodItemBloc>(context)
                  .add(DeleteFoodItemEvent(id: item.id));
              Navigator.pop(context);
            },
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
