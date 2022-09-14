import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.primaryColor, required this.title})
      : super(key: key);
  final Color primaryColor;
  final String title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      // TextFiled Column과 같이 썼을 때 문제 해결
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: TextFormField(
              decoration: InputDecoration(labelText: "제목을 입력하세요"),
            )),
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '카테고리 선택',
                  style: TextStyle(color: Colors.white, letterSpacing: 2.0),
                ),
                IconButton(onPressed: null, icon: Icon(Icons.navigate_next))
              ],
            )),
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '사진 & 영상 첨부하기',
                  style: TextStyle(color: Colors.white, letterSpacing: 2.0),
                ),
                IconButton(onPressed: null, icon: Icon(Icons.attach_file))
              ],
            )),
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '지도 첨부하기',
                  style: TextStyle(color: Colors.white, letterSpacing: 2.0),
                ),
                IconButton(onPressed: null, icon: Icon(Icons.map))
              ],
            )),
            Container(
                child: TextFormField(
              decoration:
                  const InputDecoration(labelText: "마음 온도에 올릴 게시글 내용을 작성해주세요"),
            ))
          ],
        ),
      ),
      // 글 작성 완료 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
