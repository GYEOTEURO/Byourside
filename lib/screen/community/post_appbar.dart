import 'package:byourside/model/community_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/widget/back_to_previous_page.dart';
import 'package:byourside/widget/customBottomSheet.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/icons.dart' as customIcons;

class CommunityPostAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommunityPostAppBar(
    {Key? key,
    required this.post}) 
    : super(key: key);

    CommunityPostModel post;

  @override
  State<CommunityPostAppBar> createState() => _CommunityPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityPostAppBarState extends State<CommunityPostAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<String> likesUser = [];
  List<String> scrapsUser = [];
  final SaveData saveData = SaveData();

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          //automaticallyImplyLeading: true,
          leading: backToPreviousPage(context),
          actions: [
            likesButton(isClicked(likesUser), likesUser, widget.post.category, widget.post.id!, user!.uid, updateLikes),
            scrapsButton(isClicked(scrapsUser), scrapsUser, widget.post.category, widget.post.id!, user!.uid, updateScraps),
            IconButton(
              icon: customIcons.add_ons, 
              onPressed: (){
                customBottomSheet(context, widget.post.uid == user!.uid, 
                () { deletePost(context, widget.post.category, widget.post.id!, 'community'); }, 
                () { reportPost(context, 'community', widget.post.id!); }, 
                () { blockPost(context, user!.uid, widget.post.uid); });
              }),
          ],
    );
  }

deletePost(BuildContext context, String category, String documentID, String collectionName){
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  saveData.deleteCommunityPost(category, documentID);
}

reportPost(BuildContext context, String collectionName, String id){
  saveData.report(collectionName, 'post', id);
  Navigator.pop(context);
}

blockPost(BuildContext context, String uid, String? blockUid){
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  saveData.addBlock(uid, blockUid);
}


  bool isClicked(List<String> likesOrScrapsUser) {
    if(likesOrScrapsUser.contains(user!.uid)){
      return true;
    }
    return false;
  }
}
