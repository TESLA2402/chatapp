import 'package:chatapp/constant.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:flutter/material.dart';

import '../buttons/roundedbutton.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  //const SignIn(void Function() toggleView, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: 'email'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: 'password'),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text("Forgot Password?"),
                )),
            const SizedBox(
              height: 8,
            ),
            Container(
                child: RoundedButton(
              onPressed: () {},
              text: 'Log In',
              colour: Colors.teal.shade400,
            )),
            const SizedBox(
              height: 8,
            ),
            Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 60),
                child: const Text("Dont't have account?"),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  child: const Text(
                    "SignIn",
                    style: kSendButtonTextStyle,
                  ),
                  onPressed: () {
                    widget.toggle();
                  },
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
