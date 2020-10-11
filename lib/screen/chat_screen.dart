import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chat/JK49LNlDzy5IqhRhn6gm/messages')
              .snapshots(),
          builder: (ctx, streamSnapShot) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) => Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        streamSnapShot.data.documents[i]['text'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    itemCount: streamSnapShot.data.documents.length,
                  ),
                ),
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
