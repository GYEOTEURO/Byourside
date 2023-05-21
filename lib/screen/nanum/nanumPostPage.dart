// ignore_for_file: unused_field

import 'package:byourside/screen/nanum/nanumPostCategory.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_set.dart';
import '../../model/nanum_post.dart';

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
  List<TextEditingController> _imgInfos = [];
  final User? user = FirebaseAuth.instance.currentUser;

  List<String>? _type = [];

  File? _image; // 사진 하나 가져오기
  List<XFile> _images = []; // 사진 여러 개 가져오기
  bool _visibility = false; // 가져온 사진 보이기
  final _formkey = GlobalKey<FormState>();
  int indicatorLen = 1;
  int _current = 0; // 현재 이미지 인덱스

  final picker = ImagePicker();
  final myFocus = FocusNode(); // 초점 이동
  final myFocus1 = FocusNode(); // 초점 이동

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 여러 이미지 가져오기 pickImage() 말고 pickMultiImage()

  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final List<XFile> images = await picker.pickMultiImage();

    setState(() {
      _images = images; // 가져온 이미지를 _image에 저장

      // 선택한 이미지 길이 만큼 초기화
      _imgInfos = [];
      for (int i = 0; i < images.length; i++) {
        _imgInfos.add(TextEditingController());
      }

      indicatorLen = _images.length;
      //_images = images.map<File>((xfile) => File(xfile.path)).toList();
    });
    print("이미지 세부 설명: $_imgInfos\n 이미지: $_images");
    if (indicatorLen == 0) {
      indicatorLen = 1;
      _hide();
    } else {
      _show();
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
              style: const TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "사진에 대한 간략한 설명을 적어주세요",
                hintText: "(예시) 곁으로장애복지관의 무료 미술 수업을 진행 관련 포스터 이미지",
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: const TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
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
                              style: const TextStyle(
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
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(myFocus),
                              decoration: const InputDecoration(
                                labelText: "제목을 입력하세요",
                                hintText: "제목을 입력하세요",
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF045558)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.5, color: Color(0xFF045558)),
                                ),
                                labelStyle: TextStyle(color: Color(0xFF045558)),
                              ),
                              controller: _title,
                            ))),
                    // 카테고리 선택
                    Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Row(
                          // 위젯을 양쪽으로 딱 붙임
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '카테고리 선택',
                              semanticsLabel: '카테고리(장애 유형) 선택',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NanumGothic'),
                            ),
                            IconButton(
                                onPressed: () async {
                                  HapticFeedback.lightImpact(); // 약한 진동
                                  _type = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NanumPostCategory(
                                                primaryColor:
                                                    widget.primaryColor,
                                                title: widget.title,
                                                preType: _type,
                                              )));
                                  print("타입: $_type");
                                },
                                icon: const Icon(
                                  Icons.navigate_next,
                                  semanticLabel: '카테고리(장애 유형) 선택',
                                ))
                          ],
                        )),
                    // 사진 및 영상 첨부
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Column(children: [
                          Row(
                            // 위젯을 양쪽으로 딱 붙임
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '사진 첨부하기',
                                semanticsLabel: '사진 첨부하기',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NanumGothic'),
                              ),
                              IconButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact(); // 약한 진동
                                    getImage(ImageSource.gallery);
                                    _show();
                                  },
                                  icon: const Icon(
                                    Icons.attach_file,
                                    semanticLabel: '사진 첨부하기',
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: _visibility,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '아래 각 사진에 대한 간략한 설명을 적어주세요. \n이는 보이스오버를 위한 항목으로 게시글 작성 후 따로 보이진 않습니다.',
                                    semanticsLabel:
                                        '아래 각 사진에 대한 간략한 설명을 적어주세요. \n이는 보이스오버를 위한 항목으로 게시글 작성 후 따로 보이진 않습니다.',
                                    style: TextStyle(
                                        color: Color(0xFF045558),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'NanumGothic'),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Semantics(
                                      label:
                                          "선택한 사진 목록 (총 ${_images.length}개로, 다음 사진을 보려면 가로 방향으로 넘겨주세요.",
                                      child: CarouselSlider(
                                        items: List.generate(_images.length,
                                            (index) {
                                          return Container(
                                              padding: const EdgeInsets.all(3),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Semantics(
                                    label: "현재 보이는 사진 순서 표시",
                                    child: CarouselIndicator(
                                      count: indicatorLen,
                                      index: _current,
                                      color: Colors.black26,
                                      activeColor: const Color(0xFF045558),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ))
                        ])),
                    const SizedBox(
                      height: 20,
                    ),
                    // 가격 설정
                    const Text(
                      '가격',
                      semanticsLabel: '가격',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NanumGothic'),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Semantics(
                            label: "가격을 입력하세요",
                            child: TextFormField(
                              focusNode: myFocus,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "가격은 비어있을 수 없습니다";
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(myFocus1);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                              decoration: const InputDecoration(
                                labelText: "가격을 입력하세요",
                                hintText: '₩(원) (참고: 0원 기입 시, 나눔이 됩니다)',
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFF045558)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.5, color: Color(0xFF045558)),
                                ),
                                labelStyle: TextStyle(color: Color(0xFF045558)),
                              ),
                              controller: _price,
                            ))),
                    // 게시글 내용
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '마음 나눔에 올릴 게시글 내용',
                      semanticsLabel: '마음 나눔에 올릴 게시글 내용',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NanumGothic'),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 5),
                        child: Semantics(
                            label: "마음 나눔에 올릴 게시글 내용을 작성해주세요",
                            child: TextField(
                              style: const TextStyle(
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600),
                              focusNode: myFocus1,
                              controller: _content,
                              minLines: 8,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                labelText: "마음 나눔에 올릴 게시글 내용을 작성해주세요",
                                hintText:
                                    "거래 혹은 나눔할 물건에 대한 설명, 거래 장소와 방법 등의 내용을 작성해주세요",
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
                                labelStyle: TextStyle(color: Color(0xFF045558)),
                              ),
                            )))
                  ],
                ),
              ))),
      // 글 작성 완료 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
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
            NanumPostModel postData = NanumPostModel(
                uid: user!.uid,
                nickname: user!.displayName,
                title: _title.text,
                content: _content.text,
                price: _price.text,
                type: _type,
                isCompleted: false,
                datetime: Timestamp.now(),
                images: urls,
                imgInfos: imgInfos,
                likes: 0,
                likesPeople: [],
                scrapPeople: [],
                keyword: _title.text.split(' '));
            DBSet.addNanumPost('nanumPost', postData);
          }
        },
        backgroundColor: widget.primaryColor,
        child: const Icon(
          Icons.navigate_next,
          semanticLabel: '마음 나눔 게시글 작성 완료',
        ),
      ),
    );
  }
}
