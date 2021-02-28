import 'package:flut_food_restaurant/user/models/add_update_user_argument.dart';
import 'package:flut_food_restaurant/user/screens/add_update_user.dart';
import 'package:flut_food_restaurant/user/screens/user_details.dart';
import 'package:flut_food_restaurant/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatelessWidget {
  static const String routeName = 'user-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddUpdateUser.routeName,
                  arguments: AddUpdateUserArgument());
            },
          )
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, state) {
          if (state is UserLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                CircularProgressIndicator(),
              ],
            );
          }
          if (state is UserLoadFailureState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                Text('Failed to load food users'),
              ],
            );
          }
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (ctx, idx) {
              return ListTile(
                title: Text(state.users[idx].fullName),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.users[idx].phone),
                    Text(state.users[idx].email)
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, UserDetails.routeName,
                      arguments: state.users[idx]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
