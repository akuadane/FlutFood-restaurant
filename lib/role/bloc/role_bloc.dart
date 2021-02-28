import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/role/repository/role_respository.dart';
import 'package:flutter/cupertino.dart';

part 'role_state.dart';

part 'role_event.dart';


class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleRepository roleRepository;

  RoleBloc({@required this.roleRepository})
      : super(InitialRoleState());

  @override
  Stream<RoleState> mapEventToState(
    RoleEvent event,
  ) async* {
    yield RoleLoadingState();
    if(state is RoleAddEvent){
      yield await _mapRoleAddEventToState(event);
    }else if(state is RoleUpdateEvent) {
      yield await _mapRoleUpdateEventToState(event);
    }else if(state is RoleDeleteEvent) {
      yield await _mapRoleDeleteEventToState(event);
    }else if(state is LoadRolesEvent){
      yield await _mapRoleLoadToState(event);
    }
  }
  Future<RoleState> _mapRoleAddEventToState(RoleAddEvent event) async{
    try {
      await roleRepository.createRole(event.role);
      final cats = await roleRepository.getRoles();
      return RoleLoadSuccessState(roles: cats);
    }catch(e){
      print(e);
      return RoleLoadFailureState();
    }
  }
  Future<RoleState> _mapRoleUpdateEventToState(RoleUpdateEvent event) async{
    try {
      await roleRepository.updateRole(event.role);
      final cats = await roleRepository.getRoles();
      return RoleLoadSuccessState(roles: cats);
    }catch(e){
      print(e);
      return RoleLoadFailureState();
    }
  }
  Future<RoleState> _mapRoleDeleteEventToState(RoleDeleteEvent event) async{
    try {
      await roleRepository.deleteRole(event.id);
      final cats = await roleRepository.getRoles();
      return RoleLoadSuccessState(roles: cats);
    }catch(e){
      print(e);
      return RoleLoadFailureState();
    }
  }
  Future<RoleState> _mapRoleLoadToState(LoadRolesEvent event) async{
    try {
      final cats = await roleRepository.getRoles();
      return RoleLoadSuccessState(roles: cats);
    }catch(e){
      print(e);
      return RoleLoadFailureState();
    }
  }
}
