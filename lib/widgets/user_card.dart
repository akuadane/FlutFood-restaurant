import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/widgets/role_card.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(child: Text('Full name:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text(user.fullName), flex: 3,),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(child: Text('Username:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text(user.userName), flex: 3,),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(child: Text('Email:')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text(user.email), flex: 3,),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(child: Text('Phone:'),),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text(user.phone), flex: 3,),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(child: Text('Roles')),
                    Expanded(
                      flex: 3,
                      child: ListView(
                        children: user.roles
                            .map((e) => RoleCard(
                                  role: e,
                                ))
                            .toList(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
