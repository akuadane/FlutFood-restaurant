import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/models/models.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);

  @override
  List<Object> get props => [this.orders];
}

class OrderLoadingFailure extends OrderState {}
