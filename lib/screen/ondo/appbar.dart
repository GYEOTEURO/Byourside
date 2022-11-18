import 'package:byourside/main.dart';
import 'package:flutter/material.dart';

class OndoAppBar extends StatefulWidget with PreferredSizeWidget{
  const OndoAppBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<OndoAppBar> createState() => _OndoAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}

class _OndoAppBarState extends State<OndoAppBar> {
  final TextEditingController _searchWord = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("마음온도"),
        leading: IconButton(icon: Icon(Icons.filter_alt, color: Colors.white), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed:() {search();}),
          IconButton(icon: Icon(Icons.menu, color: Colors.white), onPressed: null),
        ],
      ),
    );      
  }
  void search(){
    Container(
        child: TextFormField(
          decoration: InputDecoration(labelText: "검색어를 입력하세요"),
          controller: _searchWord,
    ));
  }

}
