

import 'package:flut_food_restaurant/colors.dart';
import 'package:flut_food_restaurant/widgets/logo_widget.dart';
import 'package:flut_food_restaurant/widgets/login_container.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoginMainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Row(),
              flutFoodLogo,
              Expanded(child: LoginContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
