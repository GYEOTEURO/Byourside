import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostList extends StatelessWidget {
  PostList({super.key});

  final String fnTitle = "title";
  final String fnContent = "content";
  final String fnDatetime = "datetime";
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    Timestamp t = document[fnDatetime];
    DateTime d = t.toDate();
    String date = d.toString();
    date = date.split(' ')[0];

    return Card(
              elevation: 2,
              child: InkWell(
                //Read Document
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Post(
                              // Post 위젯에 documentID를 인자로 넘김
                              documentID: document.id,
                            )));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                                Row(                                    
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[Text(document[fnTitle],
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    date,
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ),
              )
           );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("마음온도 게시판"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('ondoPost').snapshots(),
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
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: Colors.blueGrey,
                        title: '마음온도 글쓰기',
                      )));
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
    );
  }
}