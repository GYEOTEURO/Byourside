import 'package:byourside/main.dart';
import 'package:byourside/screen/nanum/appbar.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'nanumPostPage.dart';

class NanumPostList extends StatefulWidget {
  const NanumPostList({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;
  final String title = "마음나눔";

  @override
  State<NanumPostList> createState() => _NanumPostListState();
}

class _NanumPostListState extends State<NanumPostList> {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    Timestamp t = document["datetime"];
    DateTime d = t.toDate();
    String date = d.toString();
    date = date.split(' ')[0];

    return Container(
        height: 90,
        child: Card(
                //semanticContainer: true,
                elevation: 2,
                child: InkWell(
                  //Read Document
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NanumPost(
                                // Post 위젯에 documentID를 인자로 넘김
                                documentID: document.id,
                                primaryColor: primaryColor,
                              )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                     
                                    children: [
                                      Text(document["title"],
                                        style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      Text(
                                        date,
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  if(document["image_url"].length > 0)(
                                    Image.network(
                                      document["image_url"][0],
                                      width: 100,
                                      height: 70,
                                    )
                                  ),
                                ],
                            ),
                      )
           )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NanumAppBar(primaryColor: primaryColor),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('nanumPost').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData) return const Text('Loading...');
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data!.docs[index]),
              );
            }),
          )
        ]
      ),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NanumPostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: widget.primaryColor,
                        title: '마음나눔 글쓰기',
                      )));
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
