import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/user/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

part 'user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({@required this.userRepository}) : super(InitialUserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserLoadingState();
    print(event.runtimeType);
    if (event is UserAddEvent) {
      yield await _mapUserAddEventToState(event);
    } else if (event is UserUpdateEvent) {
      yield await _mapUserUpdateEventToState(event);
    } else if (event is UserDeleteEvent) {
      yield await _mapUserDeleteEventToState(event);
    } else if (event is LoadUsersEvent) {
      yield await _mapUserLoadToState(event);
    }
  }

  Future<UserState> _mapUserAddEventToState(UserAddEvent event) async {
    try {
      await userRepository.createUser(event.user);
      final cats = await userRepository.getUsers();
      return UserLoadSuccessState(users: cats);
    } catch (e) {
      print(e);
      return UserLoadFailureState();
    }
  }

  Future<UserState> _mapUserUpdateEventToState(UserUpdateEvent event) async {
    try {
      await userRepository.updateUser(event.user);
      final cats = await userRepository.getUsers();
      return UserLoadSuccessState(users: cats);
    } catch (e) {
      print(e);
      return UserLoadFailureState();
    }
  }

  Future<UserState> _mapUserDeleteEventToState(UserDeleteEvent event) async {
    try {
      await userRepository.deleteUser(event.id);
      final cats = await userRepository.getUsers();
      return UserLoadSuccessState(users: cats);
    } catch (e) {
      print(e);
      return UserLoadFailureState();
    }
  }

  Future<UserState> _mapUserLoadToState(LoadUsersEvent event) async {
    print("entered");
    try {
      final cats = await userRepository.getUsers();
      return UserLoadSuccessState(users: cats);
    } catch (e) {
      print(e);
      return UserLoadFailureState();
    }
  }
}
