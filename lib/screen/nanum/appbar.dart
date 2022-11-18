import 'package:byourside/main.dart';
import 'package:flutter/material.dart';

class NanumAppBar extends StatefulWidget with PreferredSizeWidget{
  const NanumAppBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<NanumAppBar> createState() => _NanumAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}

class _NanumAppBarState extends State<NanumAppBar> {
  final TextEditingController _searchWord = TextEditingController();  
  @override
  Widget build(BuildContext context)  => isCurrent("nanumPostList")
      ? Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("마음온도"),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed:() {search();}),
        ],
      ),
    ) : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("마음온도"),
        leading: IconButton(icon: Icon(Icons.filter_alt, color: Colors.white), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed:() {search();}),
        ],
      ),
    );

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    Navigator.of(context).popUntil((route) {
      print(routeName);
      print(route.settings.name);
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }


  void search(){
    // Container(
    //     child: TextFormField(
    //       decoration: InputDecoration(labelText: "검색어를 입력하세요"),
    //       controller: _searchWord,
    // ));
  }
}
