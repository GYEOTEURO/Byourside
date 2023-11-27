import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/community/add_post_appbar.dart';
import 'package:byourside/widget/community/add_post/category_section.dart';
import 'package:byourside/widget/community/add_post/content_section.dart';
import 'package:byourside/widget/community/add_post/disability_type_section.dart';
import 'package:byourside/widget/community/add_post/image_section.dart';
import 'package:byourside/widget/community/add_post/title_section.dart';
import 'package:byourside/widget/community/add_post/warning_dialog.dart';
import 'package:byourside/widget/complete_add_post_button.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/save_data.dart';
import 'package:byourside/constants/colors.dart' as colors;

class CommunityAddPost extends StatefulWidget {
  const CommunityAddPost({super.key});

  @override
  State<CommunityAddPost> createState() => _CommunityAddPostState();
}

class _CommunityAddPostState extends State<CommunityAddPost> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  List<TextEditingController> _imgInfos = [];

  String? selectedCategoryValue;
  String? selectedDisabilityTypeValue;

  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();

  List<XFile> _images = [];
  bool _visibility = false;
  final picker = ImagePicker();
  final myFocus = FocusNode();
  final _formkey = GlobalKey<FormState>();
  int _current = 0;
  int indicatorLen = 1;

  Future getImage(ImageSource imageSource) async {
    List<XFile> images = await picker.pickMultiImage();

    setState(() {
      _images = images;
      _imgInfos = [];
      for (int i = 0; i < images.length; i++) {
        _imgInfos.add(TextEditingController());
      }

      indicatorLen = _images.length;
    });
    print('이미지 세부 설명: $_imgInfos\n 이미지: $_images');
    if (indicatorLen == 0) {
      indicatorLen = 1;
      _hide();
    } else {
      _show();
    }
  }

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

  void _handleCategorySelected(String value) {
    setState(() {
      selectedCategoryValue = value;
    });
  }

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const CommunityAddPostAppBar(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: colors.appBarColor,
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            DisabilityTypeSectionInAddPost(
                              onChipSelected: _handleDisabilityTypeSelected,
                            ),
                            CategorySectionInAddPost(
                                onChipSelected: _handleCategorySelected),
                          ]),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                            child: Column(children: [
                              TitleSection(
                                  titleController: _title, focus: myFocus),
                              Container(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Column(children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                          getImage(ImageSource.gallery);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded),
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                colors.primaryColor),
                                        label: const Text('사진 추가하기',
                                            semanticsLabel: '사진 추가하기',
                                            style: TextStyle(
                                                color: colors.textColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: fonts.font))),
                                    Visibility(
                                        visible: _visibility,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Semantics(
                                                label:
                                                    '선택한 사진 목록 총 ${_images.length}개로, 다음 사진을 보려면 가로 방향으로 넘겨주세요.',
                                                child: CarouselSlider(
                                                  items: List.generate(
                                                      _images.length, (imgIdx) {
                                                    return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: imageSection(
                                                            maxWidth,
                                                            _images[imgIdx],
                                                            _imgInfos[imgIdx]));
                                                  }),
                                                  options: CarouselOptions(
                                                      height: maxWidth * 1.2,
                                                      initialPage: 0,
                                                      autoPlay: false,
                                                      enlargeCenterPage: true,
                                                      enableInfiniteScroll:
                                                          false,
                                                      viewportFraction: 1,
                                                      aspectRatio: 2.0,
                                                      onPageChanged:
                                                          (idx, reason) {
                                                        setState(() {
                                                          _current = idx;
                                                        });
                                                      }),
                                                )),
                                            Semantics(
                                                label: '현재 보이는 사진 순서 표시',
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: CarouselIndicator(
                                                    count: indicatorLen,
                                                    index: _current,
                                                    color: Colors.black26,
                                                    activeColor:
                                                        colors.primaryColor,
                                                  ),
                                                ))
                                          ],
                                        ))
                                  ]))
                            ])),
                        Container(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            width: maxWidth,
                            child: const Divider(
                                color: colors.subColor, thickness: 1.0)),
                        ContentSection(
                          contentController: _content,
                          focus: myFocus,
                        )
                      ],
                    )),
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(62, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ]),
                    child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: completeAddPostButton(() async {
                          HapticFeedback.lightImpact();
                          if (selectedCategoryValue == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const WarningDialog(
                                      warningObject: 'category');
                                });
                            return 0;
                          }
                          if (selectedDisabilityTypeValue == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const WarningDialog(
                                      warningObject: 'disabilityType');
                                });
                            return 0;
                          }

                          List<String> imgInfos = [];
                          for (int i = 0; i < _imgInfos.length; i++) {
                            if (_imgInfos[i].text == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const WarningDialog(
                                        warningObject: 'image');
                                  });
                              return 0;
                            } else {
                              imgInfos.add(_imgInfos[i].text);
                            }
                          }

                          print('사진 상세 정보: $imgInfos');

                          if (_formkey.currentState!.validate()) {
                            Navigator.pop(context);
                            List<String> urls = _images.isEmpty
                                ? []
                                : await saveData.uploadFile(_images);
                            CommunityPostModel postData = CommunityPostModel(
                                uid: user!.uid,
                                nickname: Get.find<UserController>()
                                    .userModel
                                    .nickname!,
                                title: _title.text,
                                content: _content.text,
                                category: selectedCategoryValue!,
                                disabilityType: selectedDisabilityTypeValue!,
                                createdAt: Timestamp.now(),
                                images: urls,
                                imgInfos: imgInfos,
                                likes: 0,
                                scraps: 0,
                                likesUser: [],
                                scrapsUser: [],
                                keyword: _title.text.split(' '));

                            saveData.addCommunityPost(
                                selectedCategoryValue!, postData);
                          }
                        })),
                  ))
            ])));
  }
}
