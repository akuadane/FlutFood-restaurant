import 'dart:async';
import 'package:flut_food_restaurant/authentication/repository.auth_data_repository.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flut_food_restaurant/user/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final AuthDataRepository authRepository;

  AuthenticationBloc({
    this.userRepository,
    this.authRepository,
  }) : super(AuthenticationUnknown());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield AuthenticationLoading();
    if (event is GetAuth) {
      yield await _mapGetAuthToState(event);
    } else if (event is LoginEvent) {
      yield await _mapLoginEventToState(event);
    } else if (event is SignUpEvent) {
      yield await _mapSignUpEventToState(event);
    }else if(event is LogOutEvent){
      yield await _mapLogOutEventToState(event);
    }
  }
  Future<AuthenticationState> _mapLogOutEventToState(LogOutEvent event) async {
    try {
      await authRepository.dataProvider.deleteUser();
      return AuthenticationFailed();
    } catch(e){
      print(e);
    }
  }
  Future<AuthenticationState> _mapLoginEventToState(LoginEvent event) async {
    try {
      final User user = await userRepository.getUserByUserName(event.email);
      bool authorized = false;
      for(var r in user.roles){
        if(r.name == 'admin'){
          authorized = true;
          break;
        }
      }
      if (user.password == event.password && authorized) {
        await authRepository.storeUser(user);
        print("success");
        return AuthenticationSuccess(user: user);
      } else {
        throw Exception("Invalid password");
      }
    } catch (e) {
      return AuthenticationFailed();
    }
  }

  Future<AuthenticationState> _mapSignUpEventToState(SignUpEvent event) async {
    try {
      final User user = await userRepository.createUser(event.user);

      return AuthenticationSuccess(user: user);
    } catch (e) {
      print(e);
      return AuthenticationFailed();
    }
  }

  Future<AuthenticationState> _mapGetAuthToState(
      AuthenticationEvent event) async {
    try {
      final User user = authRepository.getUser();
      return AuthenticationSuccess(user: user);
    } catch (e) {
      print(e);
      return AuthenticationFailed();
    }
  }
}
