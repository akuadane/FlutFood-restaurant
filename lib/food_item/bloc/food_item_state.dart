part of 'food_item_bloc.dart';

abstract class FoodItemState extends Equatable {
  final List<Item> items;

  const FoodItemState({this.items = const []});

  @override
  List<Object> get props => [items];
}

class FoodItemInitial extends FoodItemState {}

class FoodItemLoadingState extends FoodItemState {}

class FoodItemLoadSuccessState extends FoodItemState {
  final List<Item> items;

  const FoodItemLoadSuccessState({@required this.items}) : super(items: items);

  @override
  // TODO: implement props
  List<Object> get props => [items];
}

class FoodItemsLoadFailedState extends FoodItemState {}
