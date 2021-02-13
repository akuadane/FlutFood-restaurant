import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  IngredientBloc() : super(IngredientInitial());

  @override
  Stream<IngredientState> mapEventToState(
    IngredientEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
