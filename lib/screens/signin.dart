import 'package:chatapp/constant.dart';
import 'package:chatapp/helper/shared_preference.dart';
import 'package:chatapp/screens/chatRoom.dart';
import 'package:chatapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../buttons/roundedbutton.dart';
import '../services/database.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  //const SignIn(void Function() toggleView, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  AuthService authService = AuthService();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  signIn() async {
    if (formkey.currentState != null) {
      formkey.currentState?.validate();
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);
    }

    {
      setState(() {
        isLoading = true;
      });
      await authService
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot = await DatabaseMethods()
              .getUserInfo(emailTextEditingController.text);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0]["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0]["userEmail"]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  const Image(
                    height: 194,
                    width: 200,
                    image: AssetImage("assets/images/logo.png"),
                  ),
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Please Enter Correct Email";
                    },
                    controller: emailTextEditingController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'email'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      return val!.length > 6
                          ? null
                          : "Enter Password 6+ characters";
                    },
                    controller: passwordTextEditingController,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'password'),
                  ),
                ],
              ),
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
              onPressed: () {
                signIn();
              },
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
              ),
            ])
          ],
        ),
      ),
    );
  }
}
