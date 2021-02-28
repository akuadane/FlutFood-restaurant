part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final List<User> users;

  const UserState({this.users = const []});

  @override
  List<Object> get props => [users];
}

class InitialUserState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadSuccessState extends UserState {
  final List<User> users;

  UserLoadSuccessState({@required this.users})
      : super(users: users);
}

class UserLoadFailureState extends UserState {}
