import 'package:chat_app/screen/auth_screen.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String userName,
    String password,
    bool islogin,
  ) submit;
  AuthForm(this.submit);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submit(_userEmail, _userName, _password, _isLogin);
    }
  }

  String _userEmail = '';
  String _userName = "";
  String _password = "";

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (v) {
                          if (v.isEmpty || !v.contains("@")) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email"),
                        onSaved: (val) {
                          _userEmail = val;
                        },
                      ),
                      _isLogin
                          ? SizedBox()
                          : TextFormField(
                              validator: (v) {
                                if (v.isEmpty || v.length < 4) {
                                  return "Invalid usrname";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              decoration:
                                  InputDecoration(labelText: "User Name"),
                              onSaved: (val) {
                                _userName = val;
                              },
                            ),
                      TextFormField(
                        validator: (v) {
                          if (v.isEmpty || v.length < 8) {
                            return "Invalid Password";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        onSaved: (val) {
                          _password = val;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.redAccent,
                        onPressed: () {
                          _trySubmit();
                        },
                        child: Text(
                          _isLogin ? "Login" : "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? "Create new account" : "Login",
                            style: TextStyle(color: Colors.redAccent),
                          ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
