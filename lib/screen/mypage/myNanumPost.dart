import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';
import '../../model/db_get.dart';

class MyNanumPost extends StatefulWidget {
  MyNanumPost({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String collectionName = 'nanumPost';
  final String title = "내가 쓴 마음나눔글";

  @override
  State<MyNanumPost> createState() => _MyNanumPostState();
}

class _MyNanumPostState extends State<MyNanumPost> {
  
  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(String collectionName, PostListModel? post){
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];
    String isCompleted = (post.isCompleted == true) ? "거래완료" : "거래중";
              
    return Container(
        height: 90,
        child: Card(
                //semanticContainer: true,
                elevation: 2,
                child: InkWell(
                  //Read Document
                  onTap: () {
                    HapticFeedback.lightImpact();// 약한 진동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NanumPost(
                                // Post 위젯에 documentID를 인자로 넘김
                                collectionName: widget.collectionName,
                                documentID: post.id!,
                                primaryColor: primaryColor,
                              )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: EdgeInsets.fromLTRB(12, 10, 8, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Expanded(
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                     
                                    children: [
                                      SelectionArea(
                                        child: Text(
                                          post.title!,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                      ))),
                                      SelectionArea(
                                        child: Text(
                                          '$date / $isCompleted / ${post.type}',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(color: Colors.black),
                                      )),
                                    ],
                                  )),
                                  if(post.images!.isNotEmpty)(
                                    Semantics(
                                      label: '사용자가 올린 사진',
                                      child: Image.network(
                                        post.images![0],
                                        width: 100,
                                        height: 70,
                                    ))
                                  ),
                                ],
                            ),
                      )
           )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder<List<PostListModel>>(
      stream: DBGet.readCreatePost(collection: widget.collectionName, uid: user!.uid),
      builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  PostListModel post = snapshot.data![index];
                  return _buildListItem(widget.collectionName, post);
                });
              }
              else return const Text('게시글 목록을 가져오는 중...');
      }),
    );
  }
}
