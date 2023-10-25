import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:byourside/widget/common/scrap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  bool isClicked(List<String> scrapsUser) {
    if (scrapsUser.contains(user!.uid)) {
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
        scrapsButton(widget.collectionName, isClicked(scrapsUser), scrapsUser,
            widget.post.category, widget.post.id!, user!.uid, updateScraps),
      ],
    );
  }
}
