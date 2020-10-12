import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final String message;
  final bool isMe;
  ChatWidget(this.message, this.isMe);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(12) : Radius.circular(0)),
              color: isMe ? Colors.purple[300] : Colors.pink),
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
