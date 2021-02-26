part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  final User user;

  const AuthorizationState({this.user});

  @override
  List<Object> get props => [user];
}

class AuthorizationInitial extends AuthorizationState {
  @override
  List<Object> get props => [user];
}
