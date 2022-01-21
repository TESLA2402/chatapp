import 'package:chatapp/screens/signin.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:flutter/material.dart';

import '../buttons/roundedbutton.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
            Container(
                child: RoundedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              text: 'Log In',
              colour: Colors.teal.shade400,
            )),
            Container(
                child: RoundedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              text: 'Sign Up',
              colour: Colors.teal.shade400,
            ))
          ],
        ),
      ),
    );
  }
}
