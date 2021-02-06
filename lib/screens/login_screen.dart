import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/components/action_button.dart';
import 'package:flutter/material.dart';
import './utils/input_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  bool _saving = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: this._saving,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: logoHeroTag,
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  this.email = value;
                },
                style: TextStyle(color: Colors.black),
                decoration: buildInputDecoration('Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  this.password = value;
                },
                style: TextStyle(color: Colors.black),
                decoration: buildInputDecoration('Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ActionButton(
                onPressed: () async {
                  try {
                    setState(() {
                      this._saving = true;
                    });
                    final FirebaseUser user =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                    if (user != null) {
                      setState(() {
                        this._saving = false;
                      });
                      Navigator.pushNamed(context, ChatScreen.routeName);
                    }
                  } catch (e) {}
                },
                color: Colors.lightBlueAccent,
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
