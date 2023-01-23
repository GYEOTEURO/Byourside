import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/ondo/overlay_controller.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import '../../model/db_get.dart';

class OndoPostList extends StatefulWidget {
  const OndoPostList(
      {Key? key,
      required this.primaryColor,
      required this.collectionName,
      required this.category})
      : super(key: key);

  final Color primaryColor;
  final String collectionName;
  final String category;

  @override
  State<OndoPostList> createState() => _OndoPostListState();
}

class _OndoPostListState extends State<OndoPostList> {
  final overlayController = Get.put(OverlayController());
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

    return SizedBox(
        height: height / 7,
        child: Card(
            //semanticContainer: true,
            elevation: 2,
            child: InkWell(
                //Read Document
                onTap: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  if (overlayController.overlayEntry != null) {
                    overlayController.controlOverlay(null);
                  }
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NanumGothic'))),
                            Text(
                              widget.category.contains('전체')
                                  ? post.type!.isEmpty
                                      ? '${post.nickname!} | $date | ${post.category}'
                                      : '${post.nickname!} | $date | ${post.category} | $type'
                                  : post.type!.isEmpty
                                      ? '${post.nickname!} | $date'
                                      : '${post.nickname!} | $date | $type',
                              semanticsLabel: widget.category.contains('전체')
                                  ? post.type!.isEmpty
                                      ? '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 ${post.category}'
                                      : '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 ${post.category} $type'
                                  : post.type!.isEmpty
                                      ? '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일'
                                      : '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $type',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NanumGothic',
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
                      ]),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OndoTypeController());

    List<String> blockList;

    return Scaffold(
      body: StreamBuilder2<List<PostListModel>, DocumentSnapshot>(
          streams: StreamTuple2((widget.category.contains('전체'))
              ? ((widget.category == '전체')
                  ? DBGet.readAllCollection(
                      collection: widget.collectionName, type: controller.type)
                  : DBGet.readAllInfoCollection(
                      collection: widget.collectionName, type: controller.type))
              : DBGet.readCategoryCollection(
                  collection: widget.collectionName,
                  category: widget.category,
                  type: controller.type), 
              FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots()),
          builder: (context, snapshots) {
            if(snapshots.snapshot2.hasData){
              blockList = snapshots.snapshot2.data!["blockList"] == null ? [] : snapshots.snapshot2.data!["blockList"].cast<String>();
            }
            else{
              blockList = [];
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
                      child: Text(
                '게시글 목록 가져오는 중...',
                semanticsLabel: '게시글 목록 가져오는 중...',
                style: TextStyle(
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              )));
          }),
    );
  }
}
