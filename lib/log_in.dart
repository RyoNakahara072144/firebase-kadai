import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_kadai/sign_up.dart';
import 'package:flutter/material.dart';
import 'bulletin_board.dart';

class AuthExercise extends StatefulWidget {
  const AuthExercise({Key? key, required this .nickname,}) : super(key: key);

  final String nickname;

  @override
  State<AuthExercise> createState() => _AuthExerciseState();
}

class _AuthExerciseState extends State<AuthExercise> {
  bool _isSignedIn = false;
  String userId = '';
String nickname ='';
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        setState(() {
          _isSignedIn = false;
        });
      } else {
        userId = user.uid;//ユーザーIdの取得
        nickname = widget.nickname;
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
      
  void checkSignInState(){
      //==============================================
      //checkSignInstateを実行するとサインアップ・サインインの時に自動で画面が切り替わるようになっています。
      //SignUpで画面遷移を使わない場合は、nameの中で更に画面の切り替えをする方法が考えられます。
      //==============================================
    //body: _isSignedIn?name(userId: userId): const SignUp(),
      body: _isSignedIn?Posts(userId: userId,nickname:nickname):const SignUp(),
    );
  }
}
