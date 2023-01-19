import 'package:byourside/model/db_get.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class OndoSearch extends StatefulWidget {
  OndoSearch({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String title = "마음온도 게시글 검색";
  final String collectionName = 'ondoPost';

  @override
  State<OndoSearch> createState() => _OndoSearchState();
}

class _OndoSearchState extends State<OndoSearch> {
  final TextEditingController query = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(PostListModel? post) {
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
            elevation: 2,
            child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OndoPost(
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
                                ? '${post.nickname} | $date | ${post.category!}'
                                : '${post.nickname} | $date | ${post.category!} | $type',
                            semanticsLabel: post.type!.isEmpty
                                ? '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  ${post.category!}'
                                : '${post.nickname}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  ${post.category!}  $type',
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

    List<String> blockList;

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
                          floatingLabelStyle: TextStyle(
                            color: widget.primaryColor,
                            fontSize: 22,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w500),
                          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              color: widget.primaryColor,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: widget.primaryColor),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: widget.primaryColor),
                              borderRadius: BorderRadius.circular(20)),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          ))),
              Expanded(
                  child: StreamBuilder2<List<PostListModel>, DocumentSnapshot>(
                      streams: StreamTuple2( 
                        DBGet.readSearchDocs(query.text, collection: widget.collectionName),
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
                              itemBuilder: (_, index) {
                                PostListModel post = snapshots.snapshot1.data![index];
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
