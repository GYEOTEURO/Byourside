import 'package:byourside/screen/community/search_page.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants.dart' as constants;
import 'package:flutter/services.dart';

class CommunityAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommunityAppBar(
    {Key? key, 
    required this.title}) 
    : super(key: key);

  final String title;

  @override
  State<CommunityAppBar> createState() => _CommunityAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityAppBarState extends State<CommunityAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: constants.mainColor,
        centerTitle: true,
        title: Text(
          widget.title,
          semanticsLabel: widget.title,
        ),
        titleTextStyle:
            const TextStyle(fontFamily: constants.font, fontWeight: FontWeight.bold),
        leading: const IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.white), onPressed: null),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CommunitySearch()));
              }),
        ],
    );
  }
}
