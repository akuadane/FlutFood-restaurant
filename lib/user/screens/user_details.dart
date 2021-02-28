import 'package:flut_food_restaurant/user/bloc/user_bloc.dart';

import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/user/models/add_update_user_argument.dart';
import 'package:flut_food_restaurant/user/screens/add_update_user.dart';
import 'package:flut_food_restaurant/widgets/user_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatelessWidget {
  static const String routeName = 'user-details';

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName.toUpperCase()),
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
              Navigator.pushNamed(context, AddUpdateUser.routeName,
                  arguments: AddUpdateUserArgument(user: user, edit: true));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<UserBloc>(context)
                  .add(UserDeleteEvent(id: user.id));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(),
          UserCard(
            user: user,
          )
        ],
      ),
    );
  }
}
