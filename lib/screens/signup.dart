//import 'package:flutfood_restaurant/widgets/signup_body.dart';
//import 'package:flutter/material.dart';
//
//class SignUpPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SignUpBody(),
//    );
//  }
//}

import 'package:flutfood_restaurant/widgets/signup_body.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SignUpBody(),
    );
  }
}
