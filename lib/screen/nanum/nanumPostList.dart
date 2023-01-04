import 'package:byourside/main.dart';
import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/nanum/nanumPost.dart';
import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:byourside/screen/nanum/search_page.dart';
import 'package:flutter/material.dart';
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
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                     
                                    children: [
                                      Text(
                                        post.title!,
                                        style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      Text(
                                        '${post.nickname!} / $date / ${post.type} / $isCompleted',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  if(post.images!.isNotEmpty)(
                                    Image.network(
                                      post.images![0],
                                      width: 100,
                                      height: 70,
                                    )
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
        leading: IconButton(icon: Icon(Icons.filter_alt, color: Colors.white), 
            onPressed: () async {
                        _type = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NanumPostCategory(
                                    primaryColor: Color(0xFF045558),
                                    title: "필터링")));
                        print("타입: ${_type}");
                        controller.filtering(_type);
                        setState(() {});
                      },),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed:() { showSearch(context: context, delegate: Search('nanumPost')); }),
        ],
      ),
      body: StreamBuilder<List<PostListModel>>(
      stream: DBGet.readAllCollection(collection: widget.collectionName, type: controller.type),
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
              else return const Text('Loading...');
      }),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
