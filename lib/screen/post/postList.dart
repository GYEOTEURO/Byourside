import 'package:byourside/screen/post/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;
  final String title = "마음온도";

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar 색상 primaryColor로 지정
        backgroundColor: widget.primaryColor,
        title: Text(widget.title),
      ),
      // bottomNavigationBar: BottomNavBar(),
      // 누르면 글 작성하는 PostPage로 navigate하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostPage(
                        // PostPage 위젯에 primartColor와 title명을 인자로 넘김
                        primaryColor: widget.primaryColor,
                        title: '마음온도 글쓰기',
                      )));
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
