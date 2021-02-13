part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  final List<Ingredient> ingredients;

  const IngredientState({this.ingredients = const []});

  @override
  List<Object> get props => [ingredients];
}

class IngredientInitial extends IngredientState {
  @override
  List<Object> get props => [];
}
