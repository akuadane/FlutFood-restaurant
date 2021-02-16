part of 'food_item_bloc.dart';

abstract class FoodItemEvent extends Equatable {
  const FoodItemEvent();

  @override
  List<Object> get props => [];
}

class LoadFoodItemsEvent extends FoodItemEvent {}

class AddFoodItemEvent extends FoodItemEvent {
  final Item foodItem;

  AddFoodItemEvent({@required this.foodItem});

  @override
  List<Object> get props => [foodItem];
}

class UpdateFoodItemEvent extends FoodItemEvent {
  final Item foodItem;

  UpdateFoodItemEvent({@required this.foodItem});

  @override
  List<Object> get props => [foodItem];
}

class DeleteFoodItemEvent extends FoodItemEvent {
  final int id;

  DeleteFoodItemEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
