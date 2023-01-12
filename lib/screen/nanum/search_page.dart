import 'package:byourside/model/db_get.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NanumSearch extends StatefulWidget {
  NanumSearch({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String title = "마음나눔 게시글 검색";
  final String collectionName = 'nanumPost';

  @override
  State<NanumSearch> createState() => _NanumSearchState();
}

class _NanumSearchState extends State<NanumSearch> {
  final TextEditingController query = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  List<String> blockList = [];

  // 차단 목록
  getBlockList(String uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      List.from(value.data()!['blockList']).forEach((element) {
        if (!blockList.contains(element)) {
          blockList.add(element);
        }
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBlockList(user!.uid);
  }

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

    return Container(
        height: height / 7,
        child: Card(
            elevation: 2,
            child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NanumPost(
                              collectionName: widget.collectionName,
                              documentID: post.id!,
                              primaryColor: Color(0xFF045558))));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                ? '${post.nickname} | $date | $isCompleted'
                                : '${post.nickname} | $date | $isCompleted | $type',
                            semanticsLabel: post.type!.isEmpty
                                ? '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 | $isCompleted'
                                : '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  $isCompleted  $type',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NanumGothic',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
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
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF045558),
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  semanticLabel: "뒤로 가기", color: Colors.white),
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                Navigator.pop(context);
              }),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              Semantics(
                  label: "검색할 키워드 입력",
                  child: TextFormField(
                      controller: query,
                      maxLines: 1,
                      decoration: InputDecoration(
                          semanticCounterText: "검색할 키워드 입력",
                          labelText: "검색할 키워드를 입력해주세요.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1),
                          )))),
              Expanded(
                  child: StreamBuilder<List<PostListModel>>(
                      stream: DBGet.readSearchDocs(query.text,
                          collection: widget.collectionName),
                      builder: (context,
                          AsyncSnapshot<List<PostListModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                PostListModel post = snapshot.data![index];
                                if (blockList.contains(post.nickname)) {
                                  return Container();
                                } else {
                                  return _buildListItem(post);
                                }
                              });
                        } else
                          return Text(
                            "",
                            semanticsLabel: '',
                          );
                      }))
            ])));
  }
}
