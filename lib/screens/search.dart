import 'package:chatapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: searchSnapshot.docs[index]['userName'],
                  userEmail: searchSnapshot.docs[index]['userEmail']);
            })
        : Container();
  }

  late QuerySnapshot searchSnapshot;
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
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight),
                          borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.all(12),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          initiateSearch();
                        },
                      )),
                  searchlist()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  const SearchTile({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                userName,
                style: kSendButtonTextStyle,
              ),
              Text(userEmail, style: kSendButtonTextStyle),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //sendMessage(userName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
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
}
