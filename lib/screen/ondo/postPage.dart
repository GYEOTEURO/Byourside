import 'package:byourside/screen/ondo/postCategory.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_set.dart';
import '../../model/ondo_post.dart';

class OndoPostPage extends StatefulWidget {
  const OndoPostPage(
      {Key? key, required this.primaryColor, required this.title})
      : super(key: key);
  final Color primaryColor;
  final String title;
  // String? category;
  // String? type;

  @override
  State<OndoPostPage> createState() => _OndoPostPageState();
}

class _OndoPostPageState extends State<OndoPostPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  List<TextEditingController> _imgInfos = [];

  final User? user = FirebaseAuth.instance.currentUser;

  Category _categories = Category(null, null);

  File? _image; // 사진 하나 가져오기
  List<XFile> _images = []; // 사진 여러 개 가져오기
  bool _visibility = false; // 가져온 사진 보이기
  final picker = ImagePicker();
  final myFocus = FocusNode(); // 초점 이동
  final _formkey = GlobalKey<FormState>();
  int _current = 0; // 현재 이미지 인덱스
  int indicatorLen = 1;
  // List<dynamic> _imgInfos = []; // 사진 세부 정보

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 여러 이미지 가져오기 pickImage() 말고 pickMultiImage()
  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _images = images; // 가져온 이미지를 _image에 저장

        // 선택한 이미지 길이 만큼 초기화
        _imgInfos = [];
        for (int i = 0; i < images.length; i++)
          _imgInfos.add(TextEditingController());

        indicatorLen = _images.length;
        //_images = images.map<File>((xfile) => File(xfile.path)).toList();
      });
      print("이미지 세부 설명: ${_imgInfos}\n 이미지: ${_images}");
      if (indicatorLen == 0) {
        indicatorLen = 1;
        _hide();
      } else {
        _show();
      }
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

  Widget _imageWidget(index) {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
            label: "사용자가 선택한 사진 ${index + 1}",
            child: Image(
              image: FileImage(File(_images[index].path)),
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.7, // 보고 수정
            )),
        Semantics(
            label: "사진 ${index + 1}에 대한 간략한 설명을 적어주세요",
            child: TextFormField(
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "사진에 대한 간략한 설명을 적어주세요",
                hintText: "(예시) 곁으로장애복지관의 무료 미술 수업을 진행 관련 포스터 이미지",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFF045558)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.5, color: Color(0xFF045558)),
                ),
                labelStyle: TextStyle(color: Color(0xFF045558)),
              ),
              controller: _imgInfos[index],
            ))
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // 상단 앱 바
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        title: Text(
          widget.title,
          semanticsLabel: widget.title,
          style:
              TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: '뒤로가기',
          ),
          color: Colors.white,
        ),
      ),
      // TextFiled Column과 같이 썼을 때 문제 해결 -> SingleChildScrollView
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '제목',
                      semanticsLabel: '제목',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NanumGothic'),
                    ),
                    Container(
                        child: Semantics(
                            label: "제목을 입력하세요",
                            child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "제목은 비어있을 수 없습니다";
                                }
                                return null;
                              },
                              // style: TextStyle(fontFamily: 'NanumGothic'),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(myFocus),
                              decoration: InputDecoration(
                                  labelText: "제목을 입력하세요",
                                  hintText: "제목을 입력하세요",
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF045558)),
                                  ),
                                  labelStyle:
                                      TextStyle(color: Color(0xFF045558)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.5, color: Color(0xFF045558)),
                                  )),
                              controller: _title,
                            ))),
                    // 카테고리 선택
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: Row(
                          // 위젯을 양쪽으로 딱 붙임
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '카테고리 선택',
                              semanticsLabel: '카테고리(게시판 종류와 장애 유형) 선택',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NanumGothic'),
                            ),
                            IconButton(
                                onPressed: () async {
                                  HapticFeedback.lightImpact(); // 약한 진동
                                  _categories = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostCategory(
                                                primaryColor:
                                                    widget.primaryColor,
                                                title: widget.title,
                                                categories: _categories,
                                              )));
                                  print(
                                      "카테고리: ${_categories.category}, 타입: ${_categories.type}");
                                },
                                icon: Icon(
                                  Icons.navigate_next,
                                  semanticLabel: '카테고리(게시판 종류와 장애 유형) 선택',
                                ))
                          ],
                        )),
                    // 사진 및 영상 첨부
                    Container(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Column(children: [
                          Row(
                            // 위젯을 양쪽으로 딱 붙임
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('사진 첨부하기',
                                  semanticsLabel: '사진 첨부하기',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NanumGothic')),
                              IconButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact(); // 약한 진동
                                    getImage(ImageSource.gallery);
                                  },
                                  icon: Icon(
                                    Icons.attach_file,
                                    semanticLabel: '사진 첨부하기',
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: _visibility,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '아래 각 사진에 대한 간략한 설명을 적어주세요. \n이는 보이스오버를 위한 항목으로 게시글 작성 후 따로 보이진 않습니다.',
                                    semanticsLabel:
                                        '아래 각 사진에 대한 간략한 설명을 적어주세요. \n이는 보이스오버를 위한 항목으로 게시글 작성 후 따로 보이진 않습니다.',
                                    style: TextStyle(
                                        color: Color(0xFF045558),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'NanumGothic'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Semantics(
                                      label:
                                          "선택한 사진 목록 (총 ${_images.length}개로, 다음 사진을 보려면 가로 방향으로 넘겨주세요.",
                                      child: CarouselSlider(
                                        items: List.generate(_images.length,
                                            (index) {
                                          return Container(
                                              padding: EdgeInsets.all(3),
                                              height: maxWidth,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: _imageWidget(index));
                                        }),
                                        options: CarouselOptions(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            initialPage: 0,
                                            autoPlay: false,
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: false,
                                            viewportFraction: 1,
                                            aspectRatio: 2.0,
                                            onPageChanged: ((idx, reason) {
                                              setState(() {
                                                _current = idx;
                                              });
                                            })),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Semantics(
                                    label: "현재 보이는 사진 순서 표시",
                                    child: CarouselIndicator(
                                      count: indicatorLen,
                                      index: _current,
                                      color: Colors.black26,
                                      activeColor: widget.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ))
                        ])),
                    // 게시글 내용
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '마음 온도에 올릴 게시글 내용',
                      semanticsLabel: '마음 온도에 올릴 게시글 내용',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NanumGothic'),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: Semantics(
                            label: "마음 온도에 올릴 게시글 내용을 작성해주세요",
                            child: TextField(
                              style: TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                              focusNode: myFocus,
                              controller: _content,
                              minLines: 8,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                  labelText: "마음 온도에 올릴 게시글 내용을 작성해주세요.",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFF045558)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color(0xFF045558)),
                                  ),
                                  labelStyle:
                                      TextStyle(color: Color(0xFF045558)),
                                  hintText:
                                      "(참고: 복지/혜택 게시판과 교육/세미나 게시판은 사진을 첨부하지 않을 시,게시글 목록에서 회색 배경에 사진 없음으로 보입니다.)"),
                            )))
                  ],
                )),
          )),
      // 글 작성 완료 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
          if (_categories.category == null) {
            // Get.snackbar('카테고리 선택 실패!', '게시판 종류를 선택해주세요',
            //     backgroundColor: Colors.white);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      semanticLabel: "카테고리 선택을 실패했습니다. 게시판 종류를 선택해주세요.",
                      content: Text('게시판 종류를 선택해주세요',
                          semanticsLabel: '게시판 종류를 선택해주세요',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('확인',
                                semanticsLabel: '확인',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )))
                      ]);
                });
          } else {
            if (_formkey.currentState!.validate()) {
              Navigator.pop(context);
              List<String> urls =
                  _images.isEmpty ? [] : await DBSet.uploadFile(_images);
              List<String> imgInfos = [];
              for (int i = 0; i < _imgInfos.length; i++) {
                if (_imgInfos[i].text == "") {
                  imgInfos.add("설명 정보가 없는 사진입니다");
                } else {
                  imgInfos.add(_imgInfos[i].text);
                }
              }

              print("사진 상세 정보: ${imgInfos}");

              if (_categories.category == '자유게시판') _categories.category = '자유';

              OndoPostModel postData = OndoPostModel(
                  uid: user!.uid,
                  nickname: user!.displayName,
                  title: _title.text,
                  content: _content.text,
                  category: _categories.category,
                  type: _categories.type,
                  datetime: Timestamp.now(),
                  images: urls,
                  imgInfos: imgInfos,
                  likes: 0,
                  likesPeople: [],
                  scrapPeople: [],
                  keyword: _title.text.split(' '));
              DBSet.addOndoPost('ondoPost', postData);
            }
          }
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(
          Icons.navigate_next,
          semanticLabel: '마음 온도 게시글 작성 완료',
        ),
      ),
    );
  }
}

class Category {
  String? category;
  List<String>? type;

  Category(this.category, this.type);
}
