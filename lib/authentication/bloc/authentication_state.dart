part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final User user;
  final bool authenticated;

  const AuthenticationState({this.user, this.authenticated = false});

  @override
  List<Object> get props => [user, authenticated];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}
