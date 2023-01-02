import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:byourside/screen/ondo/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../model/db_get.dart';
import '../../model/post_list.dart';

class EduViewPage extends StatefulWidget {
  const EduViewPage({Key? key, required this.primaryColor, required this.collectionName, required this.category}) : super(key: key);
  
  final Color primaryColor;
  final String collectionName;
  final String category;

  @override
  State<EduViewPage> createState() => _EduViewPageState();
}

class _EduViewPageState extends State<EduViewPage> {

  Widget _buildListItem(String? collectionName, PostListModel? post){
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];

    return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
            //Read Document
              onTap: () {
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
              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        if(post.images!.isNotEmpty)(
                           Image.network(
                             post.images![0],
                             width: 180,
                             height: 180,)
                        ), 
                        Text(
                          post.title!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                        )),
                        Text(
                          '${post.nickname!} / $date',
                          style: const TextStyle(color: Colors.black54),
                        ),
                    ],
                  ),
                ),
              ));
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OndoTypeController());
    String collectionName = widget.collectionName;

    return Scaffold(
      body: StreamBuilder<List<PostListModel>>(
            stream: DBGet.readCategoryCollection(collection: widget.collectionName, category: widget.category, type: controller.type),
            builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
                    if(snapshot.hasData) {
                      return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                          childAspectRatio: 1 / 1.2, //item 의 가로 1, 세로 2 의 비율
                          mainAxisSpacing: 10, //수평 Padding
                          crossAxisSpacing: 10, //수직 Padding
                      ),
                      itemBuilder: (_, index) {
                        PostListModel post = snapshot.data![index];
                        return _buildListItem(collectionName, post);
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
                  builder: (context) => const OndoPostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: primaryColor,
                        title: '마음온도 글쓰기',
                      )));
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}