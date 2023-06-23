import 'package:byourside/screen/ondo/overlay_controller.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import '../../main.dart';
import '../../model/db_get.dart';
import '../../model/post_list.dart';

class PosterPage extends StatefulWidget {
  const PosterPage(
      {Key? key,
      required this.primaryColor,
      required this.collectionName,
      required this.category})
      : super(key: key);

  final Color primaryColor;
  final String collectionName;
  final String category;

  @override
  State<PosterPage> createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  final overlayController = Get.put(OverlayController());
  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(String? collectionName, PostListModel? post) {
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

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                width: width * 0.4,
                height: width * 0.4,
                child: (post.images!.isNotEmpty)
                    ? Semantics(
                        label: post.imgInfos![0],
                        child: Image.network(
                          post.images![0],
                        ))
                    : Container(
                        color: Colors.grey,
                        child: const Center(
                            child: Text('사진 없음',
                                semanticsLabel: '사진 없음',
                                style: TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                ))),
                      )),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(post.title!,
                        semanticsLabel: post.title,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NanumGothic')))),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(
                      post.type!.isEmpty
                          ? '${post.nickname!} | $date'
                          : '${post.nickname!} | $date | $type',
                      semanticsLabel: post.type!.isEmpty
                          ? '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일'
                          : '${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일  $type',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OndoTypeController());
    String collectionName = widget.collectionName;

    List<String> blockList;
    
    return Scaffold(
      body: StreamBuilder2<List<PostListModel>, DocumentSnapshot>(
          streams: StreamTuple2(
            DBGet.readCategoryCollection(collectionName: widget.collectionName, category: widget.category, type: controller.type),
            FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots()),
          builder: (context, snapshots) {
            if(snapshots.snapshot2.hasData){
              blockList = snapshots.snapshot2.data!['blockList'] == null ? [] : snapshots.snapshot2.data!['blockList'].cast<String>();
            }
            else{
              blockList = [];
            }
            if (snapshots.snapshot1.hasData) {
              return GridView.builder(
                  itemCount: snapshots.snapshot1.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.2, //item 의 가로 1, 세로 2 의 비율
                    mainAxisSpacing: 10, //수평 Padding
                    crossAxisSpacing: 8, //수직 Padding
                  ),
                  itemBuilder: (_, index) {
                    PostListModel post = snapshots.snapshot1.data![index];
                    if (blockList.contains(post.nickname)) {
                      return Container();
                    } else {
                      return _buildListItem(collectionName, post);
                    }
                  });
            } else {
              return const SelectionArea(
                  child: Center(
                      child: Text('게시물 목록을 가져오는 중...',
                          semanticsLabel: '게시물 목록을 가져오는 중...',
                          style: TextStyle(
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          ))));
            }
          }),

      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
          if (overlayController.overlayEntry != null) {
            overlayController.controlOverlay(null);
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OndoPostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: primaryColor,
                        title: '마음온도 글쓰기',
                      )));
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.add, semanticLabel: '글쓰기'),
      ),
    );
  }
}
