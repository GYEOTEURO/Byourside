import 'package:byourside/main.dart';
import 'package:byourside/screen/community/search_page.dart';
import 'package:flutter/material.dart';

class CommunityAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommunityAppBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<CommunityAppBar> createState() => _CommunityAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommunityAppBarState extends State<CommunityAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          '커뮤니티',
          semanticsLabel: '커뮤니티',
        ),
        titleTextStyle:
            const TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.bold),
        leading: const IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.white), onPressed: null),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                const CommunitySearch();
              }),
        ],
      ),
    );
  }
}
