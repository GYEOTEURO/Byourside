import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PostCategory extends StatefulWidget {
  const PostCategory(
      {Key? key,
      required this.primaryColor,
      required this.title,
      required this.categories})
      : super(key: key);
  final Color primaryColor;
  final String title;
  final Category categories;

  @override
  State<PostCategory> createState() => _PostCategoryState();
}

class ButtonProperties {
  String label;
  Color backgroundColor;
  Color fontColor;
  bool selected;

  ButtonProperties(
      {required this.label,
      this.backgroundColor = Colors.white,
      this.fontColor = Colors.black,
      this.selected = false});
}

class _PostCategoryState extends State<PostCategory> {
  String? _category = null;
  List<String>? _type = [];

  List<ButtonProperties> categoryList = [
    ButtonProperties(label: '자유게시판'),
    ButtonProperties(label: '병원/센터 후기'),
    ButtonProperties(label: '복지/혜택'),
    ButtonProperties(label: '법률/제도'),
    ButtonProperties(label: '교육/세미나'),
    ButtonProperties(label: '초기 증상 발견/생활 속 Tip'),
  ];

  @override
  void initState() {
    // TODO: 이전에 클릭한 사항들 남겨두기
    _category = widget.categories.category;
    _type = widget.categories.type;
    print('init 시 게시판 종류: ${_category}, 장애 유형: ${_type}');

    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].label == _category) {
        categoryList[i].selected = true;
        categoryList[i].backgroundColor = Color(0xFF045558);
        categoryList[i].fontColor = Colors.white;
        break;
      }
    }

    if (_type != null) {
      for (int j = 0; j < _type!.length; j++) {
        for (int i = 0; i < 2; i++) {
          if (typeList[i].label == _type![j]) {
            typeList[i].selected = true;
            typeList[i].backgroundColor = Color(0xFF045558);
            typeList[i].fontColor = Colors.white;
          }
        }
      }
    }

    super.initState();
  }

  void _onClickCategory(int index) {
    HapticFeedback.lightImpact(); // 약한 진동
    setState(() {
      if (categoryList[index].selected) {
        categoryList[index].selected = false;
        categoryList[index].backgroundColor = Colors.white;
        categoryList[index].fontColor = Colors.black;
      } else {
        // _category = categoryList[index].label;
        // widget.categories.category = _category;
        categoryList[index].selected = true;
        categoryList[index].backgroundColor = Color(0xFF045558);
        categoryList[index].fontColor = Colors.white;

        // 나머지 버튼들은 비활성화
        for (int i = 0; i < 6; i++) {
          if (i == index) {
            continue;
          } else {
            categoryList[i].selected = false;
            categoryList[i].backgroundColor = Colors.white;
            categoryList[i].fontColor = Colors.black;
          }
        }
      }
    });
  }

  List<ButtonProperties> typeList = [
    ButtonProperties(label: '발달장애'),
    ButtonProperties(label: '뇌병변장애'),
  ];

  void _onClickType(int index) {
    HapticFeedback.lightImpact(); // 약한 진동
    setState(() {
      if (typeList[index].selected) {
        typeList[index].selected = false;
        typeList[index].backgroundColor = Colors.white;
        typeList[index].fontColor = Colors.black;
      } else {
        typeList[index].selected = true;
        typeList[index].backgroundColor = Color(0xFF045558);
        typeList[index].fontColor = Colors.white;
        // 나머지 버튼들은 비활성화
        //   for (int i = 0; i < 2; i++) {
        //     if (i == index) {
        //       print(i);
        //       continue;
        //     } else {
        //       typeList[i].selected = false;
        //       typeList[i].backgroundColor = Colors.white;
        //       typeList[i].fontColor = Colors.black;
        //     }
        //   }
      }
    });
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
            HapticFeedback.lightImpact(); // 약한 진동
            // 선택한 게시판 종류 반영
            widget.categories.category = null;
            for (int i = 0; i < categoryList.length; i++) {
              if (categoryList[i].selected) {
                _category = categoryList[i].label;
                widget.categories.category = _category;
                break;
              }
            }

            // 장애 유형 selected 된 상태에 따라 type 값 지정
            _type = [];
            for (int i = 0; i < typeList.length; i++) {
              if (typeList[i].selected) {
                if (_type == null) {
                  _type = [typeList[i].label];
                } else {
                  _type!.add(typeList[i].label);
                }
              }
            }
            widget.categories.type = _type;
            if (widget.categories.category == null) {
              Get.snackbar('카테고리 선택 실패!', '게시판 종류를 선택해주세요',
                  backgroundColor: Colors.white);
            } else {
              Navigator.pop(context, widget.categories);
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            semanticLabel: '뒤로가기',
          ),
          color: Colors.white,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Center(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('게시판 종류',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'NanumGothic')))),
                Expanded(
                    flex: 2,
                    child: Row(children: [
                      Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(15),
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                return ElevatedButton(
                                    onPressed: () => _onClickCategory(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          categoryList[index].backgroundColor,
                                    ),
                                    child: Text(categoryList[index].label,
                                        style: TextStyle(
                                            color:
                                                categoryList[index].fontColor,
                                            fontFamily: 'NanumGothic',
                                            fontWeight: FontWeight.w600)));
                              }))
                    ])),
                const Center(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('장애 유형',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'NanumGothic')))),
                Expanded(
                    child: Row(children: [
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(15),
                          itemCount: typeList.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                                onPressed: () => _onClickType(index),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        typeList[index].backgroundColor),
                                child: Text(
                                  typeList[index].label,
                                  style: TextStyle(
                                      color: typeList[index].fontColor,
                                      fontFamily: 'NanumGothic',
                                      fontWeight: FontWeight.w600),
                                ));
                          }))
                ])),
              ]))),
    );
  }
}
