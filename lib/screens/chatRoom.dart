import 'package:chatapp/screens/chatbot/chatbot.dart';
import 'package:chatapp/screens/search.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/authenticate.dart';
import '../helper/constants.dart';
import '../helper/shared_preference.dart';
import '../services/database.dart';
import 'chats.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream? chatRooms;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data!.docs[index]['chatroomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data!.docs[index]['chatroomId'],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 80, right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: const Icon(
                  Icons.android,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: chatRoomsList(),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({required this.userName, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 172, 235, 174),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: const Center(
                  child: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              )),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(userName.toUpperCase(),
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
