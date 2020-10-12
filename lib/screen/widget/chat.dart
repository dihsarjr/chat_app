import 'package:chat_app/screen/widget/chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chat = snap.data.documents;
        final user = FirebaseAuth.instance.currentUser;
        return chat.length <= 0
            ? Text('data')
            : FutureBuilder(builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemBuilder: (ct, i) {
                    return ChatWidget(chat[i]['text'],
                        chat[i]["userId"] == user.uid ? true : false);
                  },
                  itemCount: chat.length,
                );
              });
      },
    );
  }
}
