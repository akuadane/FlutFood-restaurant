import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flutter/material.dart';

class RoleCardEdit extends StatelessWidget {
  final Role role;
  final Function onChanged;
  final bool value;
  final int idx;

  const RoleCardEdit({this.role, this.onChanged, this.value, this.idx});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(role.name),
      value: value,
      onChanged: (_) {
        onChanged(role);
      },
    );
    // return Card(
    //   clipBehavior: Clip.antiAlias,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Row(),
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             CheckboxListTile(
    //               title: Text(role.name),
    //               value: value,
    //               onChanged: (value) {
    //                 onChanged(value);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
