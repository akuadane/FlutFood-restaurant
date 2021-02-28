part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
class LogOutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
class SignUpEvent extends AuthenticationEvent {
  final User user;

  SignUpEvent({@required this.user});

  @override
  List<Object> get props => [user];
}

class GetAuth extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
