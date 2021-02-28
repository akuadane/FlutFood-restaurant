import 'package:flut_food_restaurant/order/data_provider/data_provider.dart';
import 'package:flut_food_restaurant/models/models.dart';

class OrderRepository {
  final OrderProvider orderProvider;

  OrderRepository(this.orderProvider) : assert(orderProvider != null);

  Future<List<Order>> getOrders() async {
    return await this.orderProvider.getOrders();
  }

  Future<Order> createOrder(Order order) async {
    return await this.orderProvider.createOrder(order);
  }

  Future<void> updateOrder(Order order) async {
    return await this.orderProvider.updateOrder(order);
  }

  Future<void> deleteOrder(int id) async {
    return await this.orderProvider.deleteOrder(id);
  }
}
