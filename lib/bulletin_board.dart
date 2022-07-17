import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'name.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  TextEditingController postEditingController = TextEditingController();
  TextEditingController nicknameEditingController = TextEditingController();



  void addPost()async{

    FutureBuilder<DocumentSnapshot>(
        future :  FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData&&snapshot.data!.exists){
            //問３
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            final nickname = userData['nickname'];
            nicknameEditingController = TextEditingController(text: nickname);
            return Center( );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );

    //問１
    await FirebaseFirestore.instance.collection('posts').add({
      'text': postEditingController.text,
      'nickname': nicknameEditingController.text,
      'date':DateTime.now().toString(),
      'id':widget.userId
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
              stream: FirebaseFirestore.instance.collection('posts').orderBy('date').limit(10).snapshots(),//日付順で並べた10のドキュメント
              builder: (context, snapshot){
                if(snapshot.hasData){
                  List<DocumentSnapshot> postsData = snapshot.data!.docs;//nullチェックをして読み込んだデータをリストに保存
                  return Expanded(
                    child: ListView.builder(
                        itemCount: postsData.length,
                        itemBuilder: (context, index){
                          Map<String, dynamic> postData = postsData[index].data() as Map<String, dynamic>;//データをMap<String, dynamic>型に変換
                          return  Container(
                            height: 60,
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text(postData['nickname']),
                              subtitle: Text(postData['text']),
                            ),
                          );
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
                      onPressed: (){addPost();},
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