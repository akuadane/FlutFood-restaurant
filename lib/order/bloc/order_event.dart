import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/models/models.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderLoad extends OrderEvent {
  const OrderLoad();

  @override
  List<Object> get props => [];
}

class OrderCreate extends OrderEvent {
  final Order order;

  OrderCreate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() {
    // TODO: implement toString
    return "Order created: Order{ $order}";
  }
}

class OrderUpdate extends OrderEvent {
  final Order order;

  OrderUpdate(this.order);

  @override
  List<Object> get props => [this.order];

  @override
  String toString() {
    return "Order updated: Order{ $order}";
  }
}

class OrderDelete extends OrderEvent {
  final Order order;

  OrderDelete(this.order);

  @override
  List<Object> get props => [this.order];

  @override
  String toString() {
    // TODO: implement toString
    return "Order deleted: Order{ $order}";
  }
}
