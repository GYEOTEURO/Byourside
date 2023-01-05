import 'dart:ffi';
// import 'package:flutter/src/widgets/basic.dart' as C;
import 'package:byourside/screen/ondo/postCategory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/db_set.dart';
import '../../model/ondo_post.dart';
import 'package:flutter/foundation.dart';

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

  final User? user = FirebaseAuth.instance.currentUser;

  Category _categories = Category(null, null);

  File? _image; // 사진 하나 가져오기
  List<XFile> _images = []; // 사진 여러 개 가져오기
  bool _visibility = false; // 가져온 사진 보이기
  final picker = ImagePicker();
  final myFocus = FocusNode(); // 초점 이동

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 여러 이미지 가져오기 pickImage() 말고 pickMultiImage()
  Future getImage(ImageSource imageSource) async {
    // final image = await picker.pickImage(source: imageSource);
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _images = images; // 가져온 이미지를 _image에 저장

        //_images = images.map<File>((xfile) => File(xfile.path)).toList();
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
        title: Text(
          widget.title,
          style:
              TextStyle(fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
        ),
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
        // actions: const [
        //   IconButton(
        //     onPressed: null,
        //     icon: Icon(
        //       Icons.menu,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
      ),
      // TextFiled Column과 같이 썼을 때 문제 해결 -> SingleChildScrollView
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 제목
                Container(
                    child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  // style: TextStyle(fontFamily: 'NanumGothic'),
                  onSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(myFocus),
                  decoration: InputDecoration(labelText: "제목을 입력하세요"),
                  controller: _title,
                )),
                // 카테고리 선택
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
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
                              HapticFeedback.lightImpact(); // 약한 진동
                              _categories = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostCategory(
                                            primaryColor: widget.primaryColor,
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
                    padding: EdgeInsets.only(top: 5, bottom: 5),
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
                                HapticFeedback.lightImpact(); // 약한 진동
                                getImage(ImageSource.gallery);
                                _show();
                              },
                              icon: Icon(
                                Icons.attach_file,
                                semanticLabel: '사진이나 영상 첨부',
                              ))
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
                                      (index) => Semantics(
                                            label: "선택한 사진 목록",
                                            child: DottedBorder(
                                              color: Colors.grey,
                                              dashPattern: [5, 3],
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(5),
                                              child: Container(
                                                child: Center(
                                                    child: _boxContents[index]),
                                                decoration: index <=
                                                        _images.length - 1
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(
                                                                File(_images[
                                                                        index]
                                                                    .path))))
                                                    : null,
                                              ),
                                            ),
                                          )).toList())))
                    ])),
                // 지도 첨부 -> 실패...
                // Container(
                //     padding: EdgeInsets.only(top: 5, bottom: 5),
                //     child: Row(
                //       // 위젯을 양쪽으로 딱 붙임
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: const [
                //         Text(
                //           '지도 첨부하기',
                //           style: TextStyle(
                //               color: Colors.black,
                //               letterSpacing: 2.0,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         IconButton(onPressed: null, icon: Icon(Icons.map))
                //       ],
                //     )),
                // 게시글 내용
                Container(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: TextField(
                      focusNode: myFocus,
                      textInputAction: TextInputAction.done,
                      controller: _content,
                      minLines: 8,
                      maxLines: 10,
                      decoration: const InputDecoration(
                          labelText: "마음 온도에 올릴 게시글 내용을 작성해주세요.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText:
                              "(참고: 복지/혜택 게시판과 교육/세미나 게시판은 사진을 첨부하지 않을 시,게시글 목록에서 흰색 배경이 보입니다.)"),
                    ))
              ],
            ),
          )),
      // 글 작성 완료 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact(); // 약한 진동
          Navigator.pop(context);
          List<String> urls =
              _images.isEmpty ? [] : await DBSet.uploadFile(_images);

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
              likes: 0,
              likesPeople: [],
              scrapPeople: [],
              keyword: _title.text.split(' '));
          DBSet.addOndoPost('ondoPost', postData);
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
  String? type;

  Category(this.category, this.type);
}
