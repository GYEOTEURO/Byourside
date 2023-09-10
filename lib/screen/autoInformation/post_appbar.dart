import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/model/save_data.dart';
import 'package:byourside/screen/bottom_nav_bar.dart';
import 'package:byourside/widget/icon_buttons.dart';
import 'package:byourside/widget/customBottomSheet.dart';
import 'package:byourside/widget/likes_button.dart';
import 'package:byourside/widget/scrap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:get/get.dart';

class AutoInformationPostAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  AutoInformationPostAppBar({Key? key, required this.post}) : super(key: key);

  String collectionName = 'autoInformation';
  final AutoInformationPostModel post;

  @override
  State<AutoInformationPostAppBar> createState() =>
      _AutoInformationPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AutoInformationPostAppBarState extends State<AutoInformationPostAppBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<String> scrapsUser = [];
  final SaveData saveData = SaveData();

  @override
  void initState() {
    super.initState();
    scrapsUser = widget.post.scrapsUser;
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
      leading: backToPreviousPage(context),
      actions: [
        scrapsButton(widget.collectionName, isClicked(scrapsUser), scrapsUser,
            widget.post.category, widget.post.id!, user!.uid, updateScraps),
      ],
    );
  }

  bool isClicked(List<String> likesOrScrapsUser) {
    if (likesOrScrapsUser.contains(user!.uid)) {
      return true;
    }
    return false;
  }
}
