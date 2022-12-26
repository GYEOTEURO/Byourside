import 'package:byourside/model/post_list.dart';
import 'package:byourside/screen/ondo/appbar.dart';
import 'package:byourside/screen/ondo/post.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:byourside/main.dart';
import '../../model/db_get.dart';

class OndoPostList extends StatefulWidget {
  const OndoPostList({Key? key, required this.primaryColor, required this.collectionName}) : super(key: key);
  final Color primaryColor;
  final String collectionName;
  final String title = "마음온도";

  @override
  State<OndoPostList> createState() => _OndoPostListState();
}

class _OndoPostListState extends State<OndoPostList> {
  Widget _buildListItem(PostListModel? post){
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];
              
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
                          builder: (context) => OndoPost(
                                // Post 위젯에 documentID를 인자로 넘김
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
                                        '${post.nickname!} / $date',
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
    return Scaffold(
      appBar: const OndoAppBar(primaryColor: primaryColor),
      body: StreamBuilder<List<PostListModel>>(
      stream: DBGet.readCollection(collection: widget.collectionName),
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
