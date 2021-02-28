import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:flut_food_restaurant/order/bloc/bloc.dart';
import 'package:flut_food_restaurant/order/data_provider/order_provider.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/screens/order_list_screen.dart';

class OrderAddScreen extends StatefulWidget {
  static String routeName = "/orderAddScreen";

  @override
  _OrderAddScreenState createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final _order = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add order"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Item id"),
                  onSaved: (value) {
                    setState(() {
                      this._order["item_id"] = int.parse(value);
                    });
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Your id"),
                  onSaved: (value) {
                    setState(() {
                      this._order["user_id"] = int.parse(value);
                    });
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Amount"),
                  onSaved: (value) {
                    setState(() {
                      this._order["quantity"] = int.parse(value);
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    final form = this._formKey.currentState;
                    if (form.validate()) {
                      form.save();

                      BlocProvider.of<OrderBloc>(context).add(
                        OrderCreate(
                          Order(
                            itemId: this._order["item_id"],
                            orderState: "Pending",
                            userId: this._order["user_id"],
                            quantity: this._order["quantity"],
                          ),
                        ),
                      );
                      Navigator.pushNamed(context, OrderListScreen.routeName);
                    }
                  },
                  child: Text("Create order"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
