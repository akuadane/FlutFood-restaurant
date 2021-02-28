import 'dart:math';

import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/colors.dart';
import 'package:flut_food_restaurant/constants.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/pages/home.dart';
import 'package:flut_food_restaurant/services/container_clipper.dart';
import 'package:flut_food_restaurant/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupContainer extends StatefulWidget {
  final VoidCallback onToggle;

  SignupContainer({this.onToggle});

  @override
  _SignupContainerState createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
  String email = '';
  String password = '';
  String fullName = '';
  bool visible = false;

  void toggleVisibility() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContainerClipper(),
      child: Container(
        color: kSecondaryColor,
        alignment: Alignment.center,
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign Up',
                    style: kButtonTextStyle.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: kTextFormFieldStyle,
                      decoration: kInputFieldDecoration.copyWith(
                          hintText: 'Enter Full name',
                          focusColor: Colors.white,
                          labelText: 'Full name',
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          )),
                      onChanged: (value) => fullName = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: kTextFormFieldStyle,
                      decoration: kInputFieldDecoration.copyWith(
                          hintText: 'Enter email',
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          )),
                      onChanged: (value) => email = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: kTextFormFieldStyle,
                      obscureText: visible ? false : true,
                      decoration: kInputFieldDecoration.copyWith(
                          hintText: 'Enter password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                              onPressed: toggleVisibility,
                              icon: visible
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )),
                          labelText: 'Password'),
                      onChanged: (value) => password = value,
                    ),
                  ),
                  CheckboxListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      'Yes! I Agree all Terms and Conditions',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RoundedButton(
                      text: 'Sign Up',
                      onPressed: () async {
                        widget.onToggle();
                        context.read<AuthenticationBloc>()
                          ..add(SignUpEvent(
                              user: User(
                                roles: [
                                  Role(id: 1, name: "admin"),
                                  Role(id: 2, name: "user"),
                                ],
                                  fullName: fullName,
                                  userName: email,
                                  email: email,
                                  password: password,
                                  phone: Random()
                                      .nextInt(1000000000)
                                      .toString())));
                        Future.delayed(Duration(seconds: 0), () {
                          if (context.read<AuthenticationBloc>().state
                              is AuthenticationSuccess) {
                            widget.onToggle();
                            Navigator.pop(context, true);
                          } else if (context.read<AuthenticationBloc>().state
                              is AuthenticationFailed) {
                            widget.onToggle();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Sign up not successful")));
                          }
                        });
                      },
                      color: Colors.white,
                      labelColor: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
