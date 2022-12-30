import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_get.dart';
import '../../model/db_set.dart';
import '../../model/nanum_post.dart';

class NanumPostContent extends StatefulWidget {
  const NanumPostContent({super.key, required this.collectionName, required this.documentID, required this.primaryColor});
  
  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<NanumPostContent> createState() => _NanumPostContentState();
}

class _NanumPostContentState extends State<NanumPostContent> {
  
  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(String? collectionName, NanumPostModel? post) {

    String date = post!.datetime!.toDate().toString().split(' ')[0];
    String changeState = post.isCompleted! ? "거래중으로 변경  " : "거래완료로 변경  ";
    String dealState = post.isCompleted! ? "거래완료" : "";

    return Column(
          children: [
           Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                post.title!,
                style: const TextStyle(fontSize: 25),
              )
            )),
            Row(
              children: [
                Expanded(
                  child: Text(
                          "${post.nickname!} / $date",
                          style: const TextStyle(color: Colors.black54),
                         )
                ),
                if(user?.uid == post.uid)(
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: changeState,
                        style: const TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                        ..onTapDown = (details) {
                          DBSet.updateIsCompleted(collectionName!, post.id!, !post.isCompleted!);
                        })
                    ])
                ))
                else(
                  Text(dealState)
                ),
                if(user?.uid == post.uid)(
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "삭제",
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                          ..onTapDown = (details) {
                            Navigator.pop(context);
                            DBSet.deletePost(collectionName!, post.id!);
                          })
                      ],
                    )
                  )),
              ]
            ),
            Divider(thickness: 1, height: 1, color: Colors.blueGrey[200]),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              alignment: Alignment.centerLeft,
              child: Text(
                "가격: ${post.price!}원",
                style: const TextStyle(fontSize: 20),
              )
            ),
            if(post.images!.isNotEmpty)(
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    for (String url in post.images!)(
                      Container(
                        child: Image.network(url),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ))
                  ], 
            ))),  
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                post.content!,
                style: const TextStyle(fontSize: 15),
              )
            ),
            Row(
              children: [
                IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                    },
                    icon: const Icon(Icons.favorite_outline),
                    color: const Color.fromARGB(255, 207, 77, 68),
                ),
                //Text(post.likes!),
                IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                  },
                  icon: const Icon(Icons.star_outline),
                  color: const Color.fromARGB(255, 244, 231, 98),
                ),
              ]
            ),
          ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;
    
    return StreamBuilder<NanumPostModel>(
            stream: DBGet.readNanumDocument(collection: collectionName, documentID: documentID),
            builder: (context, AsyncSnapshot<NanumPostModel> snapshot) {
              if(snapshot.hasData) {
                NanumPostModel? post = snapshot.data;
                return _buildListItem(collectionName, post);
              }
              else return const Text('게시물을 찾을 수 없습니다.');
    });
  }

}
