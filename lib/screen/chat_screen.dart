import 'package:chat_app/screen/widget/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [Icon(Icons.exit_to_app), Text('Logout')],
                    ),
                  ),
                  value: "logOut",
                ),
              ],
              onChanged: (v) {
                if (v == "logOut") {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chat/JK49LNlDzy5IqhRhn6gm/messages')
              .snapshots(),
          builder: (ctx, streamSnapShot) {
            return Column(
              children: [
                Expanded(child: Chat()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: textEditingController,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Firestore.instance
                              .collection('chat/JK49LNlDzy5IqhRhn6gm/messages')
                              .add({"text": textEditingController.text});
                        },
                        child: Text("sent"),
                        color: Colors.amber,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
