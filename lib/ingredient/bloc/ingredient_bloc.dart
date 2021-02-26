import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/ingredient/repository/ingredient_repository.dart';
import 'package:flutter/foundation.dart';

part 'ingredient_event.dart';

part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientRepository ingredientRepository;

  IngredientBloc({@required this.ingredientRepository})
      : super(IngredientInitial());

  @override
  Stream<IngredientState> mapEventToState(
    IngredientEvent event,
  ) async* {
    yield IngredientLoadingState();
    if (event is LoadIngredientsEvent) {
      yield await _mapLoadIngredientToState(event);
    }
  }

  Future<IngredientState> _mapLoadIngredientToState(
      LoadIngredientsEvent event) async {
    try {
      final ingredients = await ingredientRepository.getIngredients();
      return IngredientLoadSuccessState(ingredients: ingredients);
    } catch (e) {
      print(e);
      return IngredientLoadFailedState();
    }
  }
}
