import 'package:byourside/main.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:byourside/screen/nanum/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/db_get.dart';
import 'type_controller.dart';
import 'nanumPostPage.dart';

class NanumPostList extends StatefulWidget {
  const NanumPostList({Key? key, required this.primaryColor, required this.collectionName}) : super(key: key);
  final Color primaryColor;
  final String collectionName;
  final String title = "마음나눔";

  @override
  State<NanumPostList> createState() => _NanumPostListState();
}

class _NanumPostListState extends State<NanumPostList> { 
  bool completedValue = false; //true: 거래완료 제외, false: 거래완료 포함

  void changeCompletedValue(bool value){
    setState(() {              
      completedValue = !value;
    });
  }

  Widget _buildListItem(PostListModel? post){
    
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
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                      ))),
                                      SelectionArea(
                                        child: Text(
                                          '${post.nickname!} / $date / ${post.type} / $isCompleted',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14),
                                      )),
                                    ],
                                  )),
                                  if(post.images!.isNotEmpty)(
                                    Semantics(
                                      label: '사용자가 올린 사진',
                                      child: Image.network(
                                        post.images![0],
                                        width: 100,
                                        height: 100,
                                    ))
                                  ),
                                ],
                            ),
                      )
           )));
  }

  @override
  Widget build(BuildContext context) {
    String? _type;
    final controller = Get.put(NanumTypeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        centerTitle: true,
        title: Text("마음나눔"),
        leading: IconButton(
          icon: Icon(Icons.filter_alt,
          semanticLabel: "장애 유형 필터링", 
          color: Colors.white), 
            onPressed: () async {
                        HapticFeedback.lightImpact();// 약한 진동
                        _type = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NanumPostCategory(
                                    primaryColor: Color(0xFF045558),
                                    title: "필터링")));
                        print("타입: ${_type}");
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
              HapticFeedback.lightImpact();// 약한 진동
              showSearch(context: context, delegate: Search('nanumPost'));
            },
          ),
        ],
        bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: [
              (completedValue == true) ?
                (IconButton(
                  icon: Icon(Icons.check_box_outlined, 
                  semanticLabel: "거래 완료 포함",
                  color: Colors.white), 
                  onPressed:() { 
                    HapticFeedback.lightImpact();// 약한 진동
                    changeCompletedValue(completedValue);
                })
                ) : 
                (IconButton(
                  icon: Icon(Icons.square_rounded, 
                  semanticLabel: "거래 완료 제외",
                  color: Colors.white), 
                  onPressed:() { 
                    HapticFeedback.lightImpact();// 약한 진동
                    changeCompletedValue(completedValue);
                  })
                ),
              Center(
                child: Text(
                  "거래완료 제외",
                  style: TextStyle(
                    color: Colors.white
                  ),
              )),
            ],
      )))),
      body: StreamBuilder<List<PostListModel>>(
      stream: (completedValue == true) ? 
              DBGet.readIsCompletedCollection(collection: widget.collectionName, type: controller.type) 
              : DBGet.readAllCollection(collection: widget.collectionName, type: controller.type),
      builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  PostListModel post = snapshot.data![index];
                  return _buildListItem(post);
                });
              }
              else return const Text('게시물 목록을 가져오는 중...');
      }),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();// 약한 진동
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
        child: const Icon(Icons.add, semanticLabel: "글쓰기"),
      ),
    );
  }
}
