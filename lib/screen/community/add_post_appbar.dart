import 'package:byourside/constants/text.dart' as texts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommunityAddPostAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CommunityAddPostAppBar({super.key});

  @override
  State<CommunityAddPostAppBar> createState() => _CommunityAddPostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityAddPostAppBarState extends State<CommunityAddPostAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colors.lightPrimaryColor,
      elevation: 0.0,
      title: const Text(
        texts.communityAddPostTitle,
        textAlign: TextAlign.left,
        semanticsLabel: texts.communityAddPostTitle,
        style: TextStyle(
            fontFamily: fonts.font,
            fontWeight: FontWeight.w600,
            color: colors.textColor),
      ),
      leading: IconButton(onPressed: null, icon: custom_icons.addPost),
      actions: [
        IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              semanticLabel: '글쓰기 취소',
              color: Colors.black,
            ))
      ],
    );
  }
}
