import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/repository/food_item_repository.dart';
import 'package:flutter/foundation.dart';

part 'food_item_event.dart';

part 'food_item_state.dart';

class FoodItemBloc extends Bloc<FoodItemEvent, FoodItemState> {
  final FoodItemRepository foodItemRepository;

  FoodItemBloc({@required this.foodItemRepository}) : super(FoodItemInitial());

  @override
  Stream<FoodItemState> mapEventToState(
    FoodItemEvent event,
  ) async* {
    yield FoodItemLoadingState();
    if (event is LoadFoodItemsEvent) {
      yield await _mapLoadFoodItemsEventToState(event);
    } else if (event is AddFoodItemEvent) {
      yield await _mapAddFoodItemEventToState(event);
    } else if (event is UpdateFoodItemEvent) {
      yield await _mapUpdateItemLoadingEventToState(event);
    } else if (event is DeleteFoodItemEvent) {
      yield await _mapDeleteFoodItemEventToState(event);
    }
  }

  Future<FoodItemState> _mapLoadFoodItemsEventToState(
      LoadFoodItemsEvent event) async {
    try {
      final items = await foodItemRepository.getFoodItems();
      return FoodItemLoadSuccessState(items: items);
    } catch (e) {
      print(e);
      return FoodItemsLoadFailedState();
    }
  }

  Future<FoodItemState> _mapAddFoodItemEventToState(
      AddFoodItemEvent event) async {
    try {
      await foodItemRepository.createItem(event.foodItem);
      final items = await foodItemRepository.getFoodItems();
      return FoodItemLoadSuccessState(items: items);
    } catch (e) {
      return FoodItemsLoadFailedState();
    }
  }

  Future<FoodItemState> _mapUpdateItemLoadingEventToState(
      UpdateFoodItemEvent event) async {
    try {
      await foodItemRepository.updateItem(event.foodItem);
      final items = await foodItemRepository.getFoodItems();
      return FoodItemLoadSuccessState(items: items);
    } catch (e) {
      return FoodItemsLoadFailedState();
    }
  }

  Future<FoodItemState> _mapDeleteFoodItemEventToState(DeleteFoodItemEvent event) async {
    try{
      await foodItemRepository.deleteItem(event.id);
      final items = await foodItemRepository.getFoodItems();
      return FoodItemLoadSuccessState(items: items);
    }catch(e) {
      return FoodItemsLoadFailedState();
    }
  }
}
