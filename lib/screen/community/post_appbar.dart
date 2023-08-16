import 'package:byourside/constants/icons.dart';
import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/community/controller/disability_type_controller.dart';
import 'package:byourside/screen/community/search_page.dart';
import 'package:byourside/screen/mypage/my_scrap_community_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityPostAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommunityPostAppBar(
    {Key? key,
    required this.documentID,
    required this.category,
    required this.likesUser,
    required this.scrapsUser}) 
    : super(key: key);

    String documentID;
    String category;
    List<String> likesUser;
    List<String> scrapsUser;

  @override
  State<CommunityPostAppBar> createState() => _CommunityPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityPostAppBarState extends State<CommunityPostAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  final SaveData saveData = SaveData();
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          //automaticallyImplyLeading: true,
          leading: IconButton(
              icon: customIcons.back, 
              onPressed: (){
                Navigator.pop(context);
              }
            ),
          actions: [
            isClicked(widget.likesUser) ? 
              IconButton(
                icon: customIcons.communityPostLikesFull, 
                onPressed: (){
                  saveData.cancelLikeOrScrap(widget.category, widget.documentID, user!.uid, 'likes');
                   widget.likesUser.remove(user!.uid);
                }
              )
              : IconButton(
                  icon: customIcons.communityPostLikesEmpty, 
                  onPressed: (){
                    saveData.addLikeOrScrap(widget.category, widget.documentID, user!.uid, 'likes');
                    widget.likesUser.add(user!.uid);
                  }
              ),
            isClicked(widget.scrapsUser) ? 
              IconButton(
                icon: customIcons.communityPostScrapsFull, 
                onPressed: (){
                  saveData.cancelLikeOrScrap(widget.category, widget.documentID, user!.uid, 'scraps');
                  widget.scrapsUser.remove(user!.uid);
                }
              )
              : IconButton(
              icon: customIcons.communityPostScrapsEmpty, 
              onPressed: (){
                saveData.addLikeOrScrap(widget.category, widget.documentID, user!.uid, 'scraps');
                widget.scrapsUser.add(user!.uid);
              }),
            IconButton(
              icon: customIcons.add_ons, 
              onPressed: (){
                
              }),
          ],
    );
  }


bool isClicked(List<String> likesOrScrapsUser) {
  if(likesOrScrapsUser.contains(user!.uid)){
    return true;
  }
  return false;
}
}
