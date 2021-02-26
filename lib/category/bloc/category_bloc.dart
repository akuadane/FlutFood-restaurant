import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/category/repository/category_respository.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flutter/cupertino.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({@required this.categoryRepository})
      : super(InitialCategoryState());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    yield CategoryLoadingState();
    if(state is CategoryAddEvent){
      yield await _mapCategoryAddEventToState(event);
    }else if(state is CategoryUpdateEvent) {
      yield await _mapCategoryUpdateEventToState(event);
    }else if(state is CategoryDeleteEvent) {
      yield await _mapCategoryDeleteEventToState(event);
    }else if(state is LoadCategoriesEvent){
      yield await _mapCategoryLoadToState(event);
    }
  }
  Future<CategoryState> _mapCategoryAddEventToState(CategoryAddEvent event) async{
    try {
      await categoryRepository.createCategory(event.category);
      final cats = await categoryRepository.getCategories();
      return CategoryLoadSuccessState(categories: cats);
    }catch(e){
      print(e);
      return CategoryLoadFailureState();
    }
  }
  Future<CategoryState> _mapCategoryUpdateEventToState(CategoryUpdateEvent event) async{
    try {
      await categoryRepository.updateCategory(event.category);
      final cats = await categoryRepository.getCategories();
      return CategoryLoadSuccessState(categories: cats);
    }catch(e){
      print(e);
      return CategoryLoadFailureState();
    }
  }
  Future<CategoryState> _mapCategoryDeleteEventToState(CategoryDeleteEvent event) async{
    try {
      await categoryRepository.deleteCategory(event.id);
      final cats = await categoryRepository.getCategories();
      return CategoryLoadSuccessState(categories: cats);
    }catch(e){
      print(e);
      return CategoryLoadFailureState();
    }
  }
  Future<CategoryState> _mapCategoryLoadToState(LoadCategoriesEvent event) async{
    try {
      final cats = await categoryRepository.getCategories();
      return CategoryLoadSuccessState(categories: cats);
    }catch(e){
      print(e);
      return CategoryLoadFailureState();
    }
  }
}
