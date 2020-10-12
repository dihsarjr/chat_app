import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool load = false;
  final _auth = FirebaseAuth.instance;
  void _loginUser(
    String email,
    String userName,
    String password,
    bool islogin,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        load = true;
      });
      if (islogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('user')
            .document(authResult.user.uid)
            .setData({"username": userName, "email": email});
      }
    } on PlatformException catch (e) {
      print(e.message);
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(_loginUser, load);
  }
}
