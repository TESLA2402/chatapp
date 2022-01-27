import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/screens/chats.dart';
import 'package:chatapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  bool haveUserSearched = false;

  Widget searchlist() {
    return haveUserSearched
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(searchSnapshot!.docs[index]['userName'],
                  searchSnapshot!.docs[index]['userEmail']);
            })
        : Container();
  }

  QuerySnapshot? searchSnapshot;
  initiateSearch() async {
    databaseMethods.searchByName(searchTextEditingController.text).then((val) {
      setState(() {
        searchSnapshot = val;
        haveUserSearched = true;
      });
    });
  }

  @override
  void initstate() {
    super.initState();
  }

  createChatroomAndStartConversation(String userName) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [Constants.myName, userName];
      Map<String, dynamic> chatRoomMap = {
        "chatroomId": chatRoomId,
        "users": users,
      };
      databaseMethods.addChatRoom(chatRoomMap, chatRoomId);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chat(
                    chatRoomId: chatRoomId,
                  )));
    } else {
      print("you cannot send message to yourself");
    }
  }

  Widget SearchTile(String userName, String userEmail) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 6,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName.toUpperCase(),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  )),
              Text(userEmail,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(userName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEditingController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Search Username...'),
                  )),
                  IconButton(
                      onPressed: () {
                        initiateSearch();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            searchlist()
          ],
        ),
      ),
    );
  }
}
