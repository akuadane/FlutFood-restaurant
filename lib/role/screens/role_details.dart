import 'package:flut_food_restaurant/role/bloc/role_bloc.dart';
import 'package:flut_food_restaurant/role/models/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/role/screens/add_update_role.dart';
import 'package:flut_food_restaurant/widgets/role_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleDetails extends StatelessWidget {
  static const String routeName = 'food-role-details';

  @override
  Widget build(BuildContext context) {
    Role role = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(role.name.toUpperCase()),
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
              Navigator.pushNamed(context, AddUpdateRole.routeName,
                  arguments: AddUpdateScreenArgument(role: role, edit: true));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<RoleBloc>(context)
                  .add(RoleDeleteEvent(id: role.id));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(),
          RoleCard(
            role: role,
          )
        ],
      ),
    );
  }
}
