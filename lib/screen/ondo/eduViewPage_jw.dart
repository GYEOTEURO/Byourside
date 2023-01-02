import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../model/db_get.dart';
import '../../model/post_list.dart';

class EduViewPage_jw extends StatefulWidget {
  const EduViewPage_jw({Key? key, required this.primaryColor, required this.collectionName, required this.category}) : super(key: key);
  
  final Color primaryColor;
  final String collectionName;
  final String category;

  @override
  State<EduViewPage_jw> createState() => _EduViewPage_jwState();
}

class _EduViewPage_jwState extends State<EduViewPage_jw> {
  Widget _buildGridCards(PostListModel? post) {
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];

    return Card(
        //semanticContainer: true,
        elevation: 2,
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
                            primaryColor: Color(0xFF045558),
                          )));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(post.images!.isNotEmpty)(
                      Image.network(
                        post.images![0],
                        width: 100,
                        height: 70,
                      )
                      ),
                      Text(
                        post.title!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        '${post.nickname!} $date',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 1.0 / 10.0,
        children: <Widget>[
          SizedBox(
            //height: 500,
            child: StreamBuilder<List<PostListModel>>(
            stream: (widget.category == '전체') ?
              DBGet.readAllCollection(collection: widget.collectionName, type: ["발달장애", "뇌병변장애"]) : 
              DBGet.readCategoryCollection(collection: widget.collectionName, category: widget.category),
            builder: (context, AsyncSnapshot<List<PostListModel>> snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        PostListModel post = snapshot.data![index];
                        return _buildGridCards(post);
                      });
                    }
                    else return const Text('Loading...');
            }),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,

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