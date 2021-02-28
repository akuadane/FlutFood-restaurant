part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersEvent extends UserEvent {}

class UserAddEvent extends UserEvent {
  final User user;

  UserAddEvent({@required this.user});

  @override
  List<Object> get props => [User];
}

class UserUpdateEvent extends UserEvent {
  final User user;

  UserUpdateEvent({@required this.user});

  @override
  List<Object> get props => [user];
}

class UserDeleteEvent extends UserEvent {
  final int id;

  UserDeleteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
