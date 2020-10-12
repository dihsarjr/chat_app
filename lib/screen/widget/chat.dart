import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chat = snap.data.documents;
        return chat.length <= 0
            ? Text('data')
            : ListView.builder(
                itemBuilder: (ct, i) {
                  return Text(chat[i]['text']);
                },
                itemCount: chat.length,
              );
      },
    );
  }
}
