import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_kadai/name.dart';
import 'package:firebase_kadai/sign_up.dart';
import 'package:flutter/material.dart';


class AuthExercise extends StatefulWidget {
  const AuthExercise({Key? key, required this.userId}) : super(key: key);
  final String userId;


  @override
  State<AuthExercise> createState() => _AuthExerciseState();
}

class _AuthExerciseState extends State<AuthExercise> {
  bool _isSignedIn = false;
  String userId = '';

  //問３
  void checkSignInState(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        setState(() {
          _isSignedIn = false;
        });
      } else {
        userId = user.uid;//ユーザーIdの取得
        setState(() {
          _isSignedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //リスナーの実行を忘れないようにしましょう。
    checkSignInState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _isSignedIn?name(userId: userId):const SignUp(),
    );
  }
}