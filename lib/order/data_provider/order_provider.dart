import 'dart:convert';

import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flut_food_restaurant/api_config_files.dart';

class OrderProvider {
  final Client httpClient;

  OrderProvider(@required this.httpClient) : assert(httpClient != null);

  Future<List<Order>> getOrders() async {
    final response =
        await this.httpClient.get(Uri.http(baseUrl, "/v1/admin/orders"), headers: <String, String> {'api-key': adminApiKey});

    if (response.statusCode == 200) {
      final orders = jsonDecode(response.body) as List;
      return orders.map((order) => Order.fromJson(order)).toList();
    }
    throw Exception("Error fetching orders");
  }

  Future<Order> createOrder(Order order) async {
    final response = await this.httpClient.post("$baseUrl/v1/admin/orders",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'api-key': adminApiKey
        },
        body: jsonEncode(<String, dynamic>{
          "user_id": order.userId,
          "item_id": order.itemId,
          "quantity": order.quantity,
          "order_state": order.orderState,
          "placed_at": "0001-01-01T02:27:16+02:27"
        }));

    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error creating order");
  }

  Future<void> deleteOrder(int id) async {
    final response = await this.httpClient.delete(
      "$baseUrl/v1/admin/orders/$id",
      headers: <String, String>{
        'api-key': adminApiKey,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception("Error deleting order");
    }
  }

  Future<void> updateOrder(Order order) async {
    final response = await this.httpClient.put(
          Uri.http(baseUrl,"/v1/admin/orders/${order.id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'api-key': adminApiKey
          },
          body: jsonEncode(
            <String, dynamic>{
              "id": order.id,
              "user_id": order.userId,
              "item_id": order.itemId,
              "quantity": order.quantity,
              "order_state": order.orderState,
              "placed_at": "0001-01-01T02:27:16+02:27"
            },
          ),
        );
    print("$baseUrl/v1/admin/orders/:id/${order.id}");
    print(response.statusCode);
    if (response.statusCode != 200) throw Exception("Error updating order");
  }
}
