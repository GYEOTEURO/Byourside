import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NanumAppBar extends StatefulWidget with PreferredSizeWidget{
  const NanumAppBar({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  State<NanumAppBar> createState() => _NanumAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}

class _NanumAppBarState extends State<NanumAppBar> {
  String? _type;
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        centerTitle: true,
        title: Text("마음나눔"),
        leading: IconButton(
          icon: Icon(Icons.filter_alt,
          semanticLabel: "장애 유형 필터링", 
          color: Colors.white), 
            onPressed: () async {
                        HapticFeedback.lightImpact();// 약한 진동
                        _type = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NanumPostCategory(
                                    primaryColor: Color(0xFF045558),
                                    title: "필터링")));
                        print("타입: ${_type}");
                      },),
        actions: [
          IconButton(
            icon: Icon(Icons.search, 
            semanticLabel: "검색",
            color: Colors.white), 
            onPressed:() {HapticFeedback.lightImpact();}),
        ],
      ),
    );
  }
  
  
}
