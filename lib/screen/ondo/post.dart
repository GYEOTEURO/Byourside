import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Post extends StatelessWidget {
  Post({super.key, required this.documentID});
  
  final String documentID;
  final User? user = FirebaseAuth.instance.currentUser;
  
  Widget _buildListItem(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
    DocumentSnapshot<Object?>? document = snapshot.data;
    String? userName = document!["userID"];
    final TextEditingController _comment = TextEditingController();

    Timestamp t = document!["datetime"];
    DateTime d = t.toDate();
    String doc_date = d.toString();
    doc_date = doc_date.split(' ')[0];
  
    return Scaffold(
      appBar: AppBar(
        title: const Text("마음온도 게시글"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                document["title"],
                style: const TextStyle(fontSize: 25),
              )
            )),
            Row(
              children: [
                Expanded(
                  child: Text(
                          document["userID"]+" / " +doc_date,
                          style: const TextStyle(color: Colors.black54),
                         )
                ),
                if("mg" == document["userID"])(
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "수정",
                        style: const TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                        ..onTapDown = (details) {
                          updateDoc(context);
                        })
                    ],
                  )
                )),
                if("mg" == document["userID"])(
                  FloatingActionButton.extended(
                    heroTag: 'deletePost',
                    onPressed: () { deleteDoc(); },
                    label: const Text("삭제"),
                  )
                )
              ]
            ),
            const Image(
                image: AssetImage("images/cat.jpeg"),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                document["content"],
                style: const TextStyle(fontSize: 15),
              )
            ),
            Row(
              children: [
                Expanded(
                  child:IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      clickLikeButton(context);
                    },
                    icon: const Icon(Icons.favorite_outline),
                    color: const Color.fromARGB(255, 207, 77, 68),
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                  clickScrapButton(context);
                  },
                  icon: const Icon(Icons.star_outline),
                  color: const Color.fromARGB(255, 244, 231, 98),
                ),
              ]
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _comment,
                    minLines: 1,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      labelText: "댓글을 작성해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1),
                      ),
                    ))
                ),
                FloatingActionButton.extended(
                  heroTag: 'saveComment',
                  onPressed: () { createComment(_comment.text); },
                  label: const Text("저장"),    
                ),
              ]
            ),
            _showComment(context),
          ])
      )
    );
  }

   Widget _commentList(BuildContext context, DocumentSnapshot comment){
    Timestamp t = comment["datetime"];
    DateTime d = t.toDate();
    String com_date = d.toString();
    com_date = com_date.split(' ')[0];

    return Card(
              elevation: 2,
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                                Row(                                    
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[Text(comment["content"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                     comment["userID"] +" / " + com_date,
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ),
                                if(user?.uid == comment["userID"])(
                                  FloatingActionButton.extended(
                                    heroTag: 'deleteComment',
                                    onPressed: () { deleteComment(comment.id); },
                                    label: const Text("삭제"),
                                  )
                                ),
                              ],
                            ),
                          ),
              )
           ); 
  }

  Widget _showComment(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ondoPost').doc(documentID).collection('comment').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return const Text("댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!");
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => _commentList(context, snapshot.data!.docs[index]) 
              ); 
            }
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('ondoPost').doc(documentID).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(!snapshot.hasData){
                return const Text("");
              }
              return _buildListItem(context, snapshot);
            }
        );
  }


  // 문서 갱신 (Update)
  void updateDoc(BuildContext context) {
    Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: Colors.blueGrey,
                        title: '마음온도 글쓰기',
                  )
              )
    );
  }

  // 문서 삭제 (Delete)
  void deleteDoc() {
    FirebaseFirestore.instance.collection('ondoPost').doc(documentID).delete();
  }

  // 댓글 생성 (Create)
  void createComment(String content) {
    FirebaseFirestore.instance.collection('ondoPost').doc(documentID).collection('comment').add
    ({
      "userID": "haeun",
      "content": content,
      "datetime": Timestamp.now(),
    });
  }

  // 댓글 삭제 (Delete)
  void deleteComment(String commentID) {
    FirebaseFirestore.instance.collection('ondoPost').doc(documentID).collection('comment').doc(commentID).delete();
  }

  void clickLikeButton(BuildContext context){
    
  }

  void clickScrapButton(BuildContext context){
    
  }

}
