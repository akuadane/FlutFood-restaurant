part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

class LoadRolesEvent extends RoleEvent {}

class RoleAddEvent extends RoleEvent {
  final Role role;

  RoleAddEvent({@required this.role});

  @override
  List<Object> get props => [Role];
}

class RoleUpdateEvent extends RoleEvent {
  final Role role;

  RoleUpdateEvent({@required this.role});

  @override
  List<Object> get props => [role];
}

class RoleDeleteEvent extends RoleEvent {
  final int id;

  RoleDeleteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
