part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  final List<Ingredient> ingredients;

  const IngredientState({this.ingredients = const []});

  @override
  List<Object> get props => [ingredients];
}

class IngredientInitial extends IngredientState {}

class IngredientLoadingState extends IngredientState{}

class IngredientLoadSuccessState extends IngredientState {
  final List<Ingredient> ingredients;

  IngredientLoadSuccessState({@required this.ingredients});

  @override
  List<Object> get props => [ingredients];
}

class IngredientLoadFailedState extends IngredientState {}
