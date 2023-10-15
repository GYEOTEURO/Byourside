import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/post_options.dart';
import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:byourside/widget/community/likes_button.dart';
import 'package:byourside/widget/common/scrap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CommunityPostAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommunityPostAppBar(
    {Key? key,
    required this.post}) 
    : super(key: key);

  String collectionName = 'community';
  final CommunityPostModel post;

  @override
  State<CommunityPostAppBar> createState() => _CommunityPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityPostAppBarState extends State<CommunityPostAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<String> likesUser = [];
  List<String> scrapsUser = [];

  @override
  void initState() {
    super.initState();
    likesUser = widget.post.likesUser;
    scrapsUser = widget.post.scrapsUser;
  }

  void updateLikes(List<String> updatedLikesUser) {
    setState(() {
      likesUser = updatedLikesUser;
    });
  }

  void updateScraps(List<String> updatedScrapsUser) {
    setState(() {
      scrapsUser = updatedScrapsUser;
    });
  }

  bool isClicked(List<String> likesOrScrapsUser) {
    if(likesOrScrapsUser.contains(user!.uid)){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: backToPreviousPage(context),
          actions: [
            likesButton(widget.collectionName, isClicked(likesUser), likesUser, widget.post.category, widget.post.id!, user!.uid, updateLikes),
            scrapsButton(widget.collectionName, isClicked(scrapsUser), scrapsUser, widget.post.category, widget.post.id!, user!.uid, updateScraps),
            communityPostOptions(context, widget.collectionName, widget.post),
          ],
    );
  }
}
