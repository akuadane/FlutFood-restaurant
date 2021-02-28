import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flut_food_restaurant/order/bloc/bloc.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/screens/screens.dart';

class OrderUpdateScreen extends StatefulWidget {
  static String routeName = "/orderUpdateScreen";
  final Order order;

  OrderUpdateScreen(this.order) : assert(order != null);

  @override
  _OrderUpdateScreenState createState() => _OrderUpdateScreenState();
}

class _OrderUpdateScreenState extends State<OrderUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _order = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update order"),
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
                  initialValue: "${widget.order.itemId}",
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
                  initialValue: "${widget.order.userId}",
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
                  initialValue: "${widget.order.quantity}",
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
                        OrderUpdate(
                          Order(
                            id: widget.order.id,
                            itemId: this._order["item_id"],
                            orderState: widget.order.orderState,
                            userId: this._order["user_id"],
                            quantity: this._order["quantity"],
                          ),
                        ),
                      );
                      Navigator.pushNamed(context, OrderListScreen.routeName);
                    }
                  },
                  child: Text("Update order"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
