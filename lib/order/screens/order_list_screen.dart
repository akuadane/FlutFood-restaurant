import 'package:flut_food_restaurant/food_item/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:flut_food_restaurant/order/bloc/bloc.dart';
import 'package:flut_food_restaurant/models/models.dart';

import 'order_detail_screen.dart';

class OrderListScreen extends StatefulWidget {
  final String orderType;
  static String routeName = "/orderListScreen";

  OrderListScreen({@required this.orderType});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String selectedButton;

  @override
  void initState() {
    super.initState();
    selectedButton = widget.orderType.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingFailure)
              return Center(
                child: Text(
                  "Error! Can't load orders",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            if (state is OrderLoaded) {
              List<Order> orders;
              switch (widget.orderType) {
                case "PENDING":
                  orders = state.orders
                      .where((Order order) =>
                          order.orderState.toUpperCase() == "PENDING")
                      .toList();
                  break;
                case "PROCESSING":
                  orders = state.orders
                      .where((Order order) =>
                          order.orderState.toUpperCase() == "PROCESSING")
                      .toList();
                  break;
                case "PROCESSED":
                  orders = state.orders
                      .where((Order order) =>
                          order.orderState.toUpperCase() == "PROCESSED")
                      .toList();
                  break;
                default:
                  break;
              }
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(
                        "Order ${orders[index].id}",
                      ),
                      subtitle: Text("Item ${orders[index].itemId}"),
                      trailing: Text("${orders[index].orderState}"),
                      children: [
                        FutureBuilder<Item>(
                          future: context
                              .read<FoodItemBloc>()
                              .foodItemRepository
                              .getFoodItem(orders[index].itemId),
                          builder: (_, AsyncSnapshot<Item> data) {
                            if (data.hasError) {
                              return Center(child: Text("Unable to load Item"));
                            }
                            if (data.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final Item item = data.data;
                            return ListTile(
                              title: Text(
                                item.name,
                              ),
                              subtitle: Text("\$${item.price}"),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                                color: widget.orderType == "PENDING" ? Colors.deepOrange : null,
                                onPressed: () {
                                  if (selectedButton.toUpperCase() !=
                                      "PENDING") {
                                    final ord = orders[index];
                                    ord.orderState = "PENDING";
                                    context
                                        .read<OrderBloc>()
                                        .add(OrderUpdate(ord));
                                  }
                                },
                                child: Text("PENDING")),
                            FlatButton(
                              color: widget.orderType == "PROCESSING" ? Colors.deepOrange : null,
                                onPressed: () {
                                  if (selectedButton.toUpperCase() !=
                                      "PROCESSING") {
                                    final ord = orders[index];
                                    ord.orderState = "PROCESSING";
                                    context
                                        .read<OrderBloc>()
                                        .add(OrderUpdate(ord));
                                  }
                                },
                                child: Text("PROCESSING")),
                            FlatButton(
                                color: widget.orderType == "PROCESSED" ? Colors.deepOrange : null,
                                onPressed: () {
                                  if (selectedButton.toUpperCase() !=
                                      "PROCESSED") {
                                    final ord = orders[index];
                                    ord.orderState = "PROCESSED";
                                    context
                                        .read<OrderBloc>()
                                        .add(OrderUpdate(ord));
                                  }
                                },
                                child: Text("PROCESSED")),
                          ],
                        )
                      ],
                    );
                    // return Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   margin: EdgeInsets.all(10),
                    //   child: ListTile(
                    //     title: Text("Order ${orders[index].id}"),
                    //     subtitle: Text("Item ${orders[index].itemId}"),
                    //     trailing: Text("${orders[index].orderState}"),
                    //     onTap: () {
                    //       Navigator.pushNamed(
                    //           context, OrderDetailScreen.routeName,
                    //           arguments: orders[index]);
                    //     },
                    //   ),
                    // );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
