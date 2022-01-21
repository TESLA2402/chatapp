import 'package:chatapp/screens/signin.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';

import '../buttons/roundedbutton.dart';
import '../constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthService authService = AuthService();
  final formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  SignMeUP() {
    if (formkey.currentState != null) {
      formkey.currentState?.validate();
    }
    {
      setState(() {
        isLoading = true;
      });
      authService
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        print("$val");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 48,
                      ),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty || val.length < 4
                              ? "Username must contain more than 4 characters"
                              : null;
                        },
                        controller: userNameTextEditingController,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'username'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty || val.length > 6
                              ? null
                              : "Password should contain minimum 7 characters";
                        },
                        obscureText: true,
                        controller: passwordTextEditingController,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'password'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'confirm password'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Provide a valid Email ID";
                        },
                        controller: emailTextEditingController,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'email'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: const Text("Forgot Password?"),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                          child: RoundedButton(
                        onPressed: () {
                          SignMeUP();
                        },
                        text: 'Sign Up',
                        colour: Colors.teal.shade400,
                      )),
                      Row(children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 60),
                          child: const Text("Already have account?"),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            child: const Text(
                              "LogIn",
                              style: kSendButtonTextStyle,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                              );
                            },
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
