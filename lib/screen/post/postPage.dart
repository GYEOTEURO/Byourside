import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.primaryColor, required this.title})
      : super(key: key);
  final Color primaryColor;
  final String title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  File? _image; // 사진 하나 가져오기
  List<XFile> _images = []; // 사진 여러 개 가져오기
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 여러 이미지 가져오기 pickImage() 말고 pickMultiImage()
  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _images = images; // 가져온 이미지를 _image에 저장
      });
    }
  }

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
      // TextFiled Column과 같이 썼을 때 문제 해결 -> SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 제목
            Container(
                child: TextFormField(
              decoration: InputDecoration(labelText: "제목을 입력하세요"),
            )),
            // 카테고리 선택
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '카테고리 선택',
                  style: TextStyle(color: Colors.black, letterSpacing: 2.0),
                ),
                IconButton(onPressed: null, icon: Icon(Icons.navigate_next))
              ],
            )),
            // 사진 및 영상 첨부
            Container(
                child: Column(children: [
              Row(
                // 위젯을 양쪽으로 딱 붙임
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '사진 & 영상 첨부하기',
                    style: TextStyle(color: Colors.black, letterSpacing: 2.0),
                  ),
                  IconButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.attach_file))
                ],
              ),
            ])),
            // 지도 첨부
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '지도 첨부하기',
                  style: TextStyle(color: Colors.black, letterSpacing: 2.0),
                ),
                IconButton(onPressed: null, icon: Icon(Icons.map))
              ],
            )),
            // 게시글 내용
            Container(
                child: TextFormField(
              minLines: 1,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "마음 온도에 올릴 게시글 내용을 작성해주세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1),
                ),
              ),
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
