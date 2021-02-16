part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  final List<Category> categories;

  const CategoryState({this.categories = const []});

  @override
  List<Object> get props => [categories];
}

class InitialCategoryState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadSuccessState extends CategoryState {
  final List<Category> categories;

  CategoryLoadSuccessState({@required this.categories})
      : super(categories: categories);
}

class CategoryLoadFailureState extends CategoryState {}
