import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<String> getChatbotReply(String userReply) async {
    var response = await http.get(Uri.parse(
        "http://api.brainshop.ai/get?bid=167106&key=iABJFJf8sP50MTTg&uid=TimePass&msg=${userReply}"));
    var data = jsonDecode(response.body);
    return data["cnt"];
  }

  List<String> replies = [];
  TextEditingController userMessage = TextEditingController();
  StreamController chatController = StreamController();

// This is what you're looking for!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("ChatBot"),
          backgroundColor: const Color.fromARGB(255, 172, 235, 174),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: chatController.stream,
            builder: (context, AsyncSnapshot snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: replies.length,
                        itemBuilder: (context, index) {
                          return MessageTile(
                            text: replies[index],
                            index: index,
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            autofocus: true,
                            controller: userMessage,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 172, 235, 174),
                                      width: 2)),
                              disabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .disabledBorder,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          replies.add(userMessage.text);
                          chatController.sink.add(replies);
                          var botReply =
                              await getChatbotReply(userMessage.text);
                          replies.add(botReply.toString());
                          chatController.sink.add(replies);
                          userMessage.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 8, bottom: 8),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 172, 235, 174),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            }));
  }
}

class MessageTile extends StatefulWidget {
  final String text;
  final int index;
  const MessageTile({Key? key, required this.text, required this.index})
      : super(key: key);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: widget.index % 2 == 0
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: widget.index % 2 != 0
                    ? const Color.fromARGB(255, 240, 240, 240)
                    : const Color.fromARGB(255, 172, 235, 174),
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
