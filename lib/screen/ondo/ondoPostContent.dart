import 'package:byourside/model/ondo_post.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_get.dart';
import '../../model/db_set.dart';


class OndoPostContent extends StatefulWidget {
  const OndoPostContent({super.key, required this.collectionName, required this.documentID, required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<OndoPostContent> createState() => _OndoPostContentState();
}

class _OndoPostContentState extends State<OndoPostContent> {

  final User? user = FirebaseAuth.instance.currentUser;

  Widget _buildListItem(String? collectionName, OndoPostModel? post){
    
    String date = post!.datetime!.toDate().toString().split(' ')[0];

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
                          "${post.nickname!} / $date / ${post.type}",
                          style: const TextStyle(color: Colors.black54),
                         )
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
            if(post.images!.isNotEmpty)(
              Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  for (String url in post.images!)(
                    Container(
                      child: Image.network(url),
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  ))
                ], 
              ))  
            ),
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
                    post.likesPeople!.contains(user?.uid) ?
                      DBSet.cancelLike(collectionName!, post.id!, user!.uid) 
                      : DBSet.addLike(collectionName!, post.id!, user!.uid);
                  },
                  icon: post.likesPeople!.contains(user?.uid) ?
                          const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                  color:Color.fromARGB(255, 207, 77, 68)
                ),
                Text('${post.likes!} '),
                IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    post.scrapPeople!.contains(user?.uid) ?
                      DBSet.cancelScrap(collectionName!, post.id!, user!.uid) 
                      : DBSet.addScrap(collectionName!, post.id!, user!.uid);
                  },
                  icon: post.scrapPeople!.contains(user?.uid) ?
                          const Icon(Icons.star) : const Icon(Icons.star_outline),
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
    
    return StreamBuilder<OndoPostModel>(
            stream: DBGet.readOndoDocument(collection: collectionName, documentID: documentID),
            builder: (context, AsyncSnapshot<OndoPostModel> snapshot) {
              if(snapshot.hasData) {
                OndoPostModel? post = snapshot.data;
                return _buildListItem(collectionName, post);
              }
              else return const Text('게시물을 찾을 수 없습니다.');
    });
  }

}
