import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'bulletin_board.dart';
import 'package:firebase_auth/firebase_auth.dart';

class name extends StatefulWidget {
  const name({Key? key, required this.userId }) : super(key: key);
  final String userId;


  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<name> {

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nicknameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();




  void setProfile() async {
    final nickname = nicknameEditingController.text;
   await FirebaseFirestore.instance.collection('users').doc(widget.userId).set(
        {
          'id':widget.userId,
          'nickname': nickname,}
    );
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text('ニックネームを記入してください',),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: nicknameEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  setProfile();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return Posts(userId: '',);
                      }));
                },
                child: Text('掲示板へ',),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)))
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
