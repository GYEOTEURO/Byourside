import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_set.dart';
import '../../model/nanum_post.dart';
import '../ondo/postPage.dart';

class NanumPostPage extends StatefulWidget {
  const NanumPostPage(
      {Key? key, required this.primaryColor, required this.title})
      : super(key: key);
  final Color primaryColor;
  final String title;

  @override
  State<NanumPostPage> createState() => _NanumPostPageState();
}

class _NanumPostPageState extends State<NanumPostPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _content = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  String? _type;

  File? _image; // 사진 하나 가져오기
  List<XFile> _images = []; // 사진 여러 개 가져오기
  bool _visibility = false; // 가져온 사진 보이기
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 여러 이미지 가져오기 pickImage() 말고 pickMultiImage()
  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _images = images; // 가져온 이미지를 _image에 저장
        print(_images);
      });
    }
  }

  // 가져온 사진 visible 상태 변경
  void _hide() {
    setState(() {
      _visibility = false;
    });
  }

  void _show() {
    setState(() {
      _visibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _boxContents = [
      Container(),
      Container(),
      Container(),
      Container(),
      _images.length <= 5
          ? Container()
          : FittedBox(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle),
                child: Text(
                  '+${(_images.length - 5).toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            )
    ];
    return Scaffold(
      // 상단 앱 바
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
              controller: _title,
            )),
            // 카테고리 선택
            Container(
                child: Row(
              // 위젯을 양쪽으로 딱 붙임
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '카테고리 선택',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () async {
                      _type = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NanumPostCategory(
                                  primaryColor: widget.primaryColor,
                                  title: widget.title)));
                    },
                    icon: Icon(Icons.navigate_next))
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
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        _show();
                      },
                      icon: Icon(Icons.attach_file))
                ],
              ),
              Visibility(
                  visible: _visibility,
                  child: SizedBox(
                      height: 100,
                      child: GridView.count(
                          shrinkWrap:
                              true, // 높이가 설정되어있지 않았을 때 이미지 가져올 경우 생기는 위젯을 대비
                          padding: EdgeInsets.all(2),
                          // 총 10개 업로드할 수 있지만 미리보기는 5개로 제한
                          crossAxisCount: 5, // 가로로 배치할 위젯 개수 지정
                          // 가로(cross), 세로(main) 아이템 간의 간격 지정
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(
                              5,
                              (index) => DottedBorder(
                                    color: Colors.grey,
                                    dashPattern: [5, 3],
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(5),
                                    child: Container(
                                      child: Center(child: _boxContents[index]),
                                      decoration: index <= _images.length - 1
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(File(
                                                      _images[index].path))))
                                          : null,
                                    ),
                                  )).toList())))
            ])),
            // 가격 설정
            Container(
                child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              decoration: InputDecoration(labelText: "가격을 입력하세요"),
              controller: _price,
            )),
            // 게시글 내용
            Container(
                child: TextFormField(
              controller: _content,
              minLines: 1,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "마음 나눔에 올릴 게시글 내용을 작성해주세요",
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
        onPressed: () async {
          Navigator.pop(context);
          List<String> urls =
              _images.isEmpty ? [] : await DBSet.uploadFile(_images);
          NanumPostModel postData = NanumPostModel(
              uid: user!.uid,
              nickname: "mg",
              title: _title.text,
              content: _content.text,
              price: _price.text,
              // type: _type,
              isCompleted: false,
              datetime: Timestamp.now(),
              images: urls);
          DBSet.addNanumPost('nanumPost', postData);
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
