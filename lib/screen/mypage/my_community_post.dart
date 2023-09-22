import 'package:byourside/widget/community/stream_community_post.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/load_data.dart';

class MyCommunityPost extends StatefulWidget {
  const MyCommunityPost({Key? key}) : super(key: key);
  final String title = '내가 쓴 게시물';

  @override
  State<MyCommunityPost> createState() => _MyCommunityPostState();
}

class _MyCommunityPostState extends State<MyCommunityPost> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: streamCommunityPost(() => loadData.readCreatePosts(uid: user!.uid))
    );
  }
}
