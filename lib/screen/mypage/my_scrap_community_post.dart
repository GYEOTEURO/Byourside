import 'package:byourside/constants.dart' as constants;
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/community/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';
import '../../model/load_data.dart';

class MyScrapCommunityPost extends StatefulWidget {
  const MyScrapCommunityPost({Key? key}) : super(key: key);
  final Color primaryColor = constants.mainColor;
  final String collectionName = 'communityPost';
  final String title = '스크랩한 커뮤니티글';

  @override
  State<MyScrapCommunityPost> createState() => _MyScrapCommunityPostState();
}

class _MyScrapCommunityPostState extends State<MyScrapCommunityPost> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();

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
      type = '${post.type![0]}/${post.type![1]}';
    }

    return SizedBox(
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
                          builder: (context) => CommunityPost(
                                // Post 위젯에 documentID를 인자로 넘김
                                collectionName: widget.collectionName,
                                documentID: post.id!,
                                primaryColor: constants.mainColor,
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 12),
                              child: Text(post.title!,
                                  semanticsLabel: post.title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: constants.font))),
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
                                fontFamily: constants.font,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                      if (post.images!.isNotEmpty)
                        Semantics(
                            label: post.imgInfos![0],
                            child: Image.network(
                              post.images![0],
                              width: width * 0.2,
                              height: height * 0.2,
                            )),
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
            style: const TextStyle(
                fontFamily: constants.font, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF045558),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                semanticLabel: '뒤로 가기', color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder<List<PostListModel>>(
          stream: loadData.readScrapPost(
              collectionName: widget.collectionName, uid: user!.uid),
          builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    PostListModel post = snapshot.data![index];
                    return _buildListItem(widget.collectionName, post);
                  });
            } else {
              return const SelectionArea(
                  child: Center(
                      child: Text('스크랩 목록을 가져오는 중...',
                          semanticsLabel: '스크랩 목록을 가져오는 중...',
                          style: TextStyle(
                              fontFamily: constants.font,
                              fontWeight: FontWeight.w600))));
            }
          }),
    );
  }
}