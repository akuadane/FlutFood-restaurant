import 'package:flut_food_restaurant/role/models/models.dart';
import 'package:flut_food_restaurant/role/screens/add_update_role.dart';
import 'package:flut_food_restaurant/role/screens/role_details.dart';
import 'package:flut_food_restaurant/role/bloc/role_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleListScreen extends StatelessWidget {
  static const String routeName = 'food-role-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roles"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddUpdateRole.routeName,arguments: AddUpdateScreenArgument());
            },
          )
        ],
      ),
      body: BlocBuilder<RoleBloc, RoleState>(
        builder: (BuildContext context, state) {
          if (state is RoleLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                CircularProgressIndicator(),
              ],
            );
          }
          if (state is RoleLoadFailureState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                Text('Failed to load food roles'),
              ],
            );
          }
          return ListView.builder(
            itemCount: state.roles.length,
            itemBuilder: (ctx, idx) {
              return ListTile(
                title: Text(state.roles[idx].name),
                onTap: () {
                  Navigator.pushNamed(context, RoleDetails.routeName,
                      arguments: state.roles[idx]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
