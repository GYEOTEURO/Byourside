import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
                                  fontFamily: 'NanumGothic',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                        if (post.images!.isNotEmpty)
                          Semantics(
                              label: '사용자가 올린 사진',
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

    return Scaffold(
      body: StreamBuilder<List<PostListModel>>(
          stream: (widget.category.contains('전체'))
              ? ((widget.category == '전체')
                  ? DBGet.readAllCollection(
                      collection: widget.collectionName, type: controller.type)
                  : DBGet.readAllInfoCollection(
                      collection: widget.collectionName, type: controller.type))
              : DBGet.readCategoryCollection(
                  collection: widget.collectionName,
                  category: widget.category,
                  type: controller.type),
          builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    PostListModel post = snapshot.data![index];
                    return _buildListItem(post);
                  });
            } else
              return const SelectionArea(
                  child: Text(
                '게시글 목록 가져오는 중...',
                semanticsLabel: '게시글 목록 가져오는 중...',
                style: TextStyle(
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ));
          }),
    );
  }
}
