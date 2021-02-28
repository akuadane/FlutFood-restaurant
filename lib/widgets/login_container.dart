import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/colors.dart';
import 'package:flut_food_restaurant/constants.dart';
import 'package:flut_food_restaurant/pages/home.dart';
import 'package:flut_food_restaurant/widgets/rounded_button.dart';
import 'package:flut_food_restaurant/authentication/screens/signup.dart';
import 'package:flut_food_restaurant/services/container_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContainer extends StatefulWidget {
  final VoidCallback onToggle;

  LoginContainer({this.onToggle});

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool visible = false;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final authBloc = context.read<AuthenticationBloc>();
      authBloc.add(GetAuth());
      if (authBloc.state is AuthenticationSuccess) {
        final arg = (authBloc.state as AuthenticationSuccess).user;
        authBloc.close();
        Navigator.pushReplacementNamed(context, Home.routeName, arguments: arg);
      }
    });
  }

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
        color: Colors.white,
        alignment: Alignment.center,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (prev, curr) {
            return curr is AuthenticationSuccess;
          },
          listener: (ctx, state) {
            setState(() {
              widget.onToggle();
            });
            Navigator.pushReplacementNamed(ctx, Home.routeName,
                arguments: (state as AuthenticationSuccess).user);
          },
          child: Form(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login',
                      style: kButtonTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style:
                            kTextFormFieldStyle.copyWith(color: Colors.black54),
                        decoration: kInputDecoration.copyWith(
                            hintText: 'Enter email',
                            focusColor: kSecondaryColor,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryColor, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: kSecondaryColor,
                            )),
                        onChanged: (value) => email = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style:
                            kTextFormFieldStyle.copyWith(color: Colors.black54),
                        obscureText: visible ? false : true,
                        decoration: kInputDecoration.copyWith(
                            hintText: 'Enter password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kSecondaryColor, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusColor: kSecondaryColor,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kSecondaryColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: toggleVisibility,
                                icon: visible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: kSecondaryColor,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: kSecondaryColor,
                                      )),
                            labelText: 'Password'),
                        onChanged: (value) => password = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RoundedButton(
                          text: 'Login',
                          onPressed: () {
                            widget.onToggle();
                            context.read<AuthenticationBloc>().add(
                                LoginEvent(email: email, password: password));
                            Future.delayed(Duration(seconds: 0), () {
                              final state =
                                  context.read<AuthenticationBloc>().state;
                              if (state is AuthenticationSuccess) {
                                widget.onToggle();
                                final arg = state.user;
                                Navigator.pushReplacementNamed(
                                    context, Home.routeName,
                                    arguments: arg);
                              } else if (state is AuthenticationFailed) {
                                widget.onToggle();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Login Failed"),
                                ));
                              }
                            });
                          },
                          color: kSecondaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        FlatButton(
                          onPressed: () async {
                            bool result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                            print(result);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("$result"),
                            ));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: kSecondaryColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
