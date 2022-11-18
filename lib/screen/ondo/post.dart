import 'package:byourside/screen/ondo/appbar.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../main.dart';

class Post extends StatefulWidget {
  Post({super.key, required this.documentID, required this.primaryColor});

  final String documentID;
  final Color primaryColor;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? nickname = "";

  Widget _buildListItem(String documentID, BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    DocumentSnapshot<Object?>? document = snapshot.data;

    FirebaseFirestore.instance
        .collection('user')
        .doc(document!["userID"])
        .get()
        .then((value) async => await (nickname = value["nickname"]));

    final TextEditingController _comment = TextEditingController();

    Timestamp t = document!["datetime"];
    DateTime d = t.toDate();
    String doc_date = d.toString();
    doc_date = doc_date.split(' ')[0];

    return Scaffold(
        appBar: OndoAppBar(primaryColor: primaryColor),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(
                        document["title"],
                        style: const TextStyle(fontSize: 25),
                      ))),
                  Row(children: [
                    Expanded(
                        child: Text(
                      nickname! + " / " + doc_date,
                      style: const TextStyle(color: Colors.black54),
                    )),
                    if (user?.uid == document["userID"])
                      (RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                              text: "수정  ",
                              style: const TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTapDown = (details) {
                                  updateDoc(context);
                                })
                        ],
                      ))),
                    if (user?.uid == document["userID"])
                      (RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                              text: "삭제",
                              style: const TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTapDown = (details) {
                                  deleteDoc(documentID);
                                })
                        ],
                      ))),
                  ]),
                  Divider(thickness: 1, height: 1, color: Colors.blueGrey[200]),
                  if (document["image_url"].length > 0)
                    (Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: [
                            for (String url in document["image_url"])
                              (Container(
                                child: Image.network(url),
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              ))
                          ],
                        ))),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        document["content"],
                        style: const TextStyle(fontSize: 15),
                      )),
                  Row(children: [
                    Expanded(
                      child: IconButton(
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
                  ]),
                  Row(children: [
                    //댓글 위치 고정
                    //Spacer(),
                    Expanded(
                      child: TextField(
                          controller: _comment,
                          minLines: 1,
                          maxLines: 8,
                          decoration: const InputDecoration(
                            labelText: "댓글을 작성해주세요.",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1),
                            ),
                          )),
                    ),
                    FloatingActionButton.extended(
                      heroTag: 'saveComment',
                      onPressed: () {
                        createComment(documentID, _comment.text);
                      },
                      label: const Icon(Icons.send),
                      backgroundColor: primaryColor,
                    ),
                  ]),
                  _showComment(documentID, context),
                ]))));
  }

  Widget _commentList(
      String documentID, BuildContext context, DocumentSnapshot comment) {
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
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Text(comment["content"],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            comment["userID"] + " / " + com_date,
                            style: const TextStyle(color: Colors.black54),
                          )),
                          if (user?.uid == comment["userID"])
                            RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "삭제",
                                    style: const TextStyle(color: Colors.black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTapDown = (details) {
                                        deleteComment(documentID, comment.id);
                                      })
                              ],
                            ))
                        ]),
                  ],
                ))));
  }

  Widget _showComment(String documentID, BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ondoPost')
            .doc(documentID)
            .collection('comment')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("댓글이 없습니다. 첫 댓글의 주인공이 되어보세요!");
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => _commentList(
                  documentID, context, snapshot.data!.docs[index]));
        });
  }

  @override
  Widget build(BuildContext context) {
    String documentID = widget.documentID;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ondoPost')
            .doc(documentID)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("");
          }
          return _buildListItem(documentID, context, snapshot);
        });
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
                )));
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String documentID) {
    FirebaseFirestore.instance.collection('ondoPost').doc(documentID).delete();
  }

  // 댓글 생성 (Create)
  void createComment(String documentID, String content) {
    FirebaseFirestore.instance
        .collection('ondoPost')
        .doc(documentID)
        .collection('comment')
        .add({
      "userID": user?.uid,
      "content": content,
      "datetime": Timestamp.now(),
    });
  }

  // 댓글 삭제 (Delete)
  void deleteComment(String documentID, String commentID) {
    FirebaseFirestore.instance
        .collection('ondoPost')
        .doc(documentID)
        .collection('comment')
        .doc(commentID)
        .delete();
  }

  void clickLikeButton(BuildContext context) {}

  void clickScrapButton(BuildContext context) {}
}
