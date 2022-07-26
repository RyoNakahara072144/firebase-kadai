import 'package:flutter/material.dart';
import 'log_in.dart';


class name extends StatefulWidget {
  const name({Key? key,}) : super(key: key);


  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<name> {

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nicknameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  String nickname ='';




  @override
  Widget build(BuildContext context) {
    //==============================================
    //画面遷移を使わない場合は、nameの中でalreadySignedUpの値に応じて画面の切り替えをする方法が考えられます
    //==============================================
    //body: alreadySignedUp?Posts(userId: widget.userId):Container(~)
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
                //##############################################################
                //現在のページに画面遷移するのは非推奨です。
                //##############################################################
                //if(nicknameEditingController.text !=''){
                //  Navigator.of(context).push(
                //    MaterialPageRoute(builder: (context) {
                //        return AuthExercise(nickname: nicknameEditingController.text);
                //}
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      if (nicknameEditingController.text != '') {
                        return AuthExercise(nickname: nicknameEditingController.text);
                      } else {
                        return name();
                      }
                    }));
                },
              child: Text('掲示板へ'),
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
