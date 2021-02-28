import 'package:flut_food_restaurant/order/bloc/bloc.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc(this.orderRepository)
      : assert(orderRepository != null),
        super(OrderLoading());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is OrderLoad) {
      yield OrderLoading();
      try {
        List<Order> orders = await this.orderRepository.getOrders();
        yield OrderLoaded(orders);
      } catch (_) {
        yield OrderLoadingFailure();
      }
    } else if (event is OrderCreate) {
      try {
        await this.orderRepository.createOrder(event.order);
        List<Order> orders = await this.orderRepository.getOrders();
        yield OrderLoaded(orders);
      } catch (_) {
        yield OrderLoadingFailure();
      }
    } else if (event is OrderDelete) {
      try {
        await this.orderRepository.deleteOrder(event.order.id);
        List<Order> orders = await this.orderRepository.getOrders();
        yield OrderLoaded(orders);
      } catch (_) {
        yield OrderLoadingFailure();
      }
    } else if (event is OrderUpdate) {
      try {
        await this.orderRepository.updateOrder(event.order);
        List<Order> orders = await this.orderRepository.getOrders();
        yield OrderLoaded(orders);
        print("success update");
      } catch (_) {
        yield OrderLoadingFailure();
      }
    }
  }
}
