part of 'food_item_bloc.dart';

abstract class FoodItemState extends Equatable {
  final List<Item> items;

  const FoodItemState(this.items);

  @override
  List<Object> get props => [items];
}

class FoodItemInitial extends FoodItemState {
  const FoodItemInitial() : super(const []);

  @override
  List<Object> get props => [];
}
