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
    String date = post!.datetime!.toDate().toString().split(' ')[0];

    return Container(
        height: 90,
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
                          SelectionArea(
                              child: Text(post.title!,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SelectionArea(
                              child: Text(
                            '${post.nickname!} / $date / ${post.type}',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )),
                        ],
                      )),
                      if (post.images!.isNotEmpty)
                        Semantics(
                            label: '사용자가 올린 사진',
                            child: Image.network(
                              post.images![0],
                              width: 100,
                              height: 100,
                            )),
                    ],
                  ),
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
              return const Text('게시글 목록 가져오는 중...');
          }),

      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact(); // 약한 진동
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
        child: const Icon(Icons.add, semanticLabel: "글쓰기"),
      ),
    );
  }
}
