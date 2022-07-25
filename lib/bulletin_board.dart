import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Posts extends StatefulWidget {
  const Posts({Key? key, required this.userId,required this.nickname}) : super(key: key);
  final String userId;
  final String nickname;
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  TextEditingController postEditingController = TextEditingController();
  String email ='';
  String nickname = '';
  String userId = '';


  void setProfile() async{
    //問２
    nickname = widget.nickname;
    userId = widget.userId;

    if(nickname != '') {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId)
          .set(
          {'userId': userId,
            'nickname': nickname,
          }
      );
    }
  }



  void addPost()async{

    DocumentSnapshot document =await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    Map<String,dynamic>userData =document.data() as Map<String,dynamic>;

    //問１
    await FirebaseFirestore.instance.collection('posts').add({
      'text': postEditingController.text,
      'date':DateTime.now().toString(),
      'nickname':userData['nickname'],
      'id':widget.userId,


    });
    postEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Column(
        children: [


          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('date').limit(20).snapshots(),//日付順で並べた10のドキュメント
              builder: (context, snapshot){
                if(snapshot.hasData ){
                  List<DocumentSnapshot> postsData = snapshot.data!.docs;//nullチェックをして読み込んだデータをリストに保存
                  return Expanded(
                    child: ListView.builder(
                        itemCount: postsData.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> postData = postsData[index]
                              .data() as Map<String,
                              dynamic>; //データをMap<String, dynamic>型に変換
                          String userId = widget.userId;
                          if (postData['id'] == userId) {
                            return Container(
                            height: 60,
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text(postData['nickname']),
                              subtitle: Text(postData['text']),
                            ),
                          );
                          }else{
                            return Container(
                              height: 60,
                              child: ListTile(
                                title: Text(postData['nickname']),
                                subtitle: Text(postData['text']),
                              ),
                            );
                          }
                        }
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              children: [
                Flexible(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      controller: postEditingController,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                      onPressed: (){
                        setProfile();
                        addPost();},
                      icon: const Icon(Icons.send)
                  ),
                )
              ],
            ),
          ),
        ],

      ),

    );
  }
}