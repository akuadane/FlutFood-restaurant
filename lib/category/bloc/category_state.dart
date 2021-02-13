part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  final List<Category> categories;

  const CategoryState({this.categories = const []});

  @override
  List<Object> get props => [categories];
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}
