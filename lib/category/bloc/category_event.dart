part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {}

class CategoryAddEvent extends CategoryEvent {
  final Category category;

  CategoryAddEvent({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryUpdateEvent extends CategoryEvent {
  final Category category;

  CategoryUpdateEvent({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryDeleteEvent extends CategoryEvent {
  final int id;

  CategoryDeleteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
