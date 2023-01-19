import 'package:byourside/main.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:byourside/screen/nanum/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import '../../model/db_get.dart';
import 'type_controller.dart';
import 'nanumPostPage.dart';

class NanumPostList extends StatefulWidget {
  const NanumPostList(
      {Key? key, required this.primaryColor, required this.collectionName})
      : super(key: key);
  final Color primaryColor;
  final String collectionName;
  final String title = "마음나눔";

  @override
  State<NanumPostList> createState() => _NanumPostListState();
}

class _NanumPostListState extends State<NanumPostList> {
  bool completedValue = false; //true: 거래완료 제외, false: 거래완료 포함
  List<String>? _type;

  void changeCompletedValue(bool value) {
    setState(() {
      completedValue = !value;
    });
  }

  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(PostListModel? post) {
    String date =
        post!.datetime!.toDate().toString().split(' ')[0].replaceAll('-', '/');
    String isCompleted = (post.isCompleted == true) ? "거래완료" : "거래중";

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? type;
    if (post.type!.length == 1) {
      type = post.type![0];
    } else if (post.type!.length > 1) {
      post.type!.sort();
      type = "${post.type![0]}/${post.type![1]}";
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
                          builder: (context) => NanumPost(
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
                                ? '${post.nickname!} | $date | $isCompleted'
                                : '${post.nickname!} | $date | $isCompleted | $type',
                            semanticsLabel: post.type!.isEmpty
                                ? '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  $isCompleted'
                                : '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  $isCompleted  $type',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
                      if (post.images!.isNotEmpty)
                        (Semantics(
                            label: post.imgInfos![0],
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
    final controller = Get.put(NanumTypeController());

    List<String> blockList;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: widget.primaryColor,
          centerTitle: true,
          title: Text("마음나눔",
              semanticsLabel: '마음나눔',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          leading: IconButton(
              icon: Icon(Icons.filter_alt,
                  semanticLabel: "장애 유형 필터링", color: Colors.white),
              onPressed: () async {
                HapticFeedback.lightImpact(); // 약한 진동
                _type = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NanumPostCategory(
                              primaryColor: Color(0xFF045558),
                              title: "필터링",
                              preType: _type,
                            )));
                print("나눔 타입: ${_type}");
                controller.filtering(_type);
                setState(() {});
              }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: "검색",
              ),
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NanumSearch()));
              },
            ),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      (completedValue == true)
                          ? (IconButton(
                              icon: Icon(Icons.check_box_outlined,
                                  semanticLabel: "거래 완료 포함",
                                  color: Colors.white),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                changeCompletedValue(completedValue);
                              }))
                          : (IconButton(
                              icon: Icon(Icons.square_rounded,
                                  semanticLabel: "거래 완료 제외",
                                  color: Colors.white),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                changeCompletedValue(completedValue);
                              })),
                      Center(
                          child: Text(
                        "거래완료 제외",
                        semanticsLabel: "거래완료 제외",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NanumGothic',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ],
                  )))),
      body: StreamBuilder2<List<PostListModel>, DocumentSnapshot>(
          streams: StreamTuple2((completedValue == true)
              ? DBGet.readIsCompletedCollection(
                  collection: widget.collectionName, type: controller.type)
              : DBGet.readAllCollection(
                  collection: widget.collectionName, type: controller.type),
              FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots()),
          builder: (context, snapshots) {
            if(snapshots.snapshot2.data!["blockList"] == null){
              blockList = [];
            }
            else{
              blockList = snapshots.snapshot2.data!["blockList"].cast<String>();
            }
            if (snapshots.snapshot1.hasData) {
              return ListView.builder(
                  itemCount: snapshots.snapshot1.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    PostListModel post = snapshots.snapshot1.data![index];
                    if (blockList.contains(post.nickname)) {
                      return Container();
                    } else {
                      return _buildListItem(post);
                    }
                  });
            } else
              return const SelectionArea(
                  child: Center(
                      child: Text('게시물 목록을 가져오는 중...',
                          semanticsLabel: '게시물 목록을 가져오는 중...',
                          style: TextStyle(
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          ))));
          }),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NanumPostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: primaryColor,
                        title: '마음나눔 글쓰기',
                      )));
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.add, semanticLabel: "마음나눔 글쓰기"),
      ),
    );
  }
}
