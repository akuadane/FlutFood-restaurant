import 'package:flutfood_restaurant/screens/components/already_have_an_account_acheck.dart';
import 'file:///C:/Users/tsede/AndroidStudioProjects/AMPLab/FlutFood-restaurant/lib/screens/login/background.dart';
import 'package:flutfood_restaurant/screens/components/rounded_button.dart';
import 'package:flutfood_restaurant/screens/components/rounded_input_field.dart';
import 'package:flutfood_restaurant/screens/components/rounded_password_field.dart';
import 'package:flutfood_restaurant/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/hamburger.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
