import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';

part 'food_item_event.dart';
part 'food_item_state.dart';

class FoodItemBloc extends Bloc<FoodItemEvent, FoodItemState> {
  FoodItemBloc() : super(FoodItemInitial());

  @override
  Stream<FoodItemState> mapEventToState(
    FoodItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
