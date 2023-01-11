import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';
import '../../model/db_get.dart';

class MyScrapOndoPost extends StatefulWidget {
  MyScrapOndoPost({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String collectionName = 'ondoPost';
  final String title = "스크랩한 마음온도글";

  @override
  State<MyScrapOndoPost> createState() => _MyScrapOndoPostState();
}

class _MyScrapOndoPostState extends State<MyScrapOndoPost> {
  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(String collectionName, PostListModel? post) {
    String date =
        post!.datetime!.toDate().toString().split(' ')[0].replaceAll('-', '/');

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? type;
    if (post.type!.length == 1) {
      type = post.type![0];
    } else if (post.type!.length > 1) {
      post.type!.sort();
      type = "${post.type![0]}/${post.type![1]}";
    }

    return Container(
        height: height / 7,
        child: Card(
            //semanticContainer: true,
            elevation: 2,
            child: InkWell(
                //Read Document
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OndoPost(
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
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 12),
                              child: Text(post.title!,
                                  semanticsLabel: post.title!,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NanumGothic'))),
                          Text(
                            post.type!.isEmpty
                                ? '${post.nickname} | $date | ${post.category!}'
                                : '${post.nickname} | $date | ${post.category!} | $type',
                            semanticsLabel: post.type!.isEmpty
                                ? '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  ${post.category!}'
                                : '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  ${post.category!} $type',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumGothic',
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                      if (post.images!.isNotEmpty)
                        (Semantics(
                            label: '사용자가 올린 사진',
                            child: Image.network(
                              post.images![0],
                              width: width * 0.2,
                              height: height * 0.2,
                            ))),
                    ],
                  ),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, semanticLabel: "뒤로 가기", color: Colors.white), onPressed: () { Navigator.pop(context); }),
      ),
      body: StreamBuilder<List<PostListModel>>(
          stream: DBGet.readScrapPost(
              collection: widget.collectionName, uid: user!.uid),
          builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    PostListModel post = snapshot.data![index];
                    return _buildListItem(widget.collectionName, post);
                  });
            } else
              return const SelectionArea(
                  child: Text('스크랩 목록을 가져오는 중...',
                      semanticsLabel: '스크랩 목록을 가져오는 중...',
                      style: TextStyle(
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600)));
          }),
    );
  }
}
