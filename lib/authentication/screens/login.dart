import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/colors.dart';
import 'package:flut_food_restaurant/pages/home.dart';
import 'package:flut_food_restaurant/widgets/logo_widget.dart';
import 'package:flut_food_restaurant/widgets/login_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final authBloc = context.read<AuthenticationBloc>();
      authBloc.add(GetAuth());
      Future.delayed(Duration(seconds: 1), () {
        if (authBloc.state is AuthenticationSuccess) {
          final arg = (authBloc.state as AuthenticationSuccess).user;
          authBloc.close();
          Navigator.pushNamed(context, Home.routeName, arguments: arg);
        }
      });
    });
  }
  void _toggleIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoginMainColor,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Row(),
                flutFoodLogo,
                Expanded(
                    child: LoginContainer(
                  onToggle: _toggleIsLoading,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
