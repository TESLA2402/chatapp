import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "ChatRoom",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 172, 235, 174),
              fontSize: 26,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    elevation: 0.0,
  );
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.teal, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
