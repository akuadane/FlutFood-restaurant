part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class LoadIngredientsEvent extends IngredientEvent {}

class AddIngredientEvent extends IngredientEvent {
  final Ingredient ingredient;

  AddIngredientEvent({@required this.ingredient});

  @override
  List<Object> get props => [ingredient];
}

class UpdateIngredientEvent extends IngredientEvent {
  final Ingredient ingredient;

  UpdateIngredientEvent({@required this.ingredient});

  @override
  List<Object> get props => [ingredient];
}

class DeleteIngredientEvent extends IngredientEvent {
  final int id;

  DeleteIngredientEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
