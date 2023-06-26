import 'package:byourside/main.dart';
import 'package:flutter/material.dart';

class OndoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const OndoAppBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<OndoAppBar> createState() => _OndoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OndoAppBarState extends State<OndoAppBar> {
  final TextEditingController _searchWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          '마음온도',
          semanticsLabel: '마음온도',
        ),
        titleTextStyle:
            const TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.bold),
        leading: const IconButton(
            icon: Icon(Icons.filter_alt, color: Colors.white), onPressed: null),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                search();
              }),
          const IconButton(
              icon: Icon(Icons.menu, color: Colors.white), onPressed: null),
        ],
      ),
    );
  }

  void search() {
    Container(
        child: TextFormField(
      decoration: const InputDecoration(labelText: '검색어를 입력하세요'),
      controller: _searchWord,
    ));
  }
}
