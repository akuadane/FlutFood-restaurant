part of 'role_bloc.dart';

abstract class RoleState extends Equatable {
  final List<Role> roles;

  const RoleState({this.roles = const []});

  @override
  List<Object> get props => [roles];
}

class InitialRoleState extends RoleState {}

class RoleLoadingState extends RoleState {}

class RoleLoadSuccessState extends RoleState {
  final List<Role> roles;

  RoleLoadSuccessState({@required this.roles})
      : super(roles: roles);
}

class RoleLoadFailureState extends RoleState {}
