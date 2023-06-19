import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants.dart' as constants;

class PostCategory extends StatefulWidget {
  const PostCategory({Key? key, required this.title, required this.categories})
      : super(key: key);
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
  String? _category;
  List<String>? _type = [];

  List<ButtonProperties> categoryList = [
    ButtonProperties(label: '자유게시판'),
    ButtonProperties(label: '병원/센터 후기'),
    ButtonProperties(label: '복지/혜택'),
    ButtonProperties(label: '법률/제도'),
    ButtonProperties(label: '교육/세미나'),
    ButtonProperties(label: '초기 증상 발견/생활 속 Tip'),
  ];

  // 게시판 카테고리 버튼 활성화
  void setCategorySelected(int index) {
    categoryList[index].selected = true;
    categoryList[index].backgroundColor = constants.mainColor;
    categoryList[index].fontColor = Colors.white;
  }

  // 게시판 카테고리 버튼 비활성화
  void setCategoryUnselected(int index) {
    categoryList[index].selected = false;
    categoryList[index].backgroundColor = Colors.white;
    categoryList[index].fontColor = Colors.black;
  }

  // 해당 index 제외한 나머지 카테고리 버튼들은 비활성화
  void setOtherCategoryUnselected(int index) {
    for (int i = 0; i < categoryList.length; i++) {
      if (i == index) {
        continue;
      } else {
        setCategoryUnselected(i);
      }
    }
  }

  // 장애 유형 버튼 활성화
  void setTypeSelected(int index) {
    typeList[index].selected = true;
    typeList[index].backgroundColor = constants.mainColor;
    typeList[index].fontColor = Colors.white;
  }

  // 장애 유형 버튼 비활성화
  void setTypeUnselected(int index) {
    typeList[index].selected = false;
    typeList[index].backgroundColor = Colors.white;
    typeList[index].fontColor = Colors.black;
  }

  @override
  void initState() {
    // TODO: 이전에 클릭한 사항들 남겨두기
    _category = widget.categories.category;
    _type = widget.categories.type;
    print('init 시 게시판 종류: $_category, 장애 유형: $_type');

    // for in 혹은 for each로 변경 !
    // for 문에서 i, j를 지양 -> i라기 보다는 index 이런 식으로 변수명 의미있게 변경 !
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].label == _category) {
        categoryList[i].selected = true;
        categoryList[i].backgroundColor = constants.mainColor;
        categoryList[i].fontColor = Colors.white;
        break;
      }
    }

    // 함수로서 이 파트를 설명해도 될 듯 !
    // _typeinit 이런식으로 !
    // _type 명도 정확히 알 수 있게 변경 !
    if (_type != null) {
      for (int j = 0; j < _type!.length; j++) {
        // 2 :  magic number !
        for (int i = 0; i < 2; i++) {
          if (typeList[i].label == _type![j]) {
            typeList[i].selected = true;
            typeList[i].backgroundColor = constants.mainColor;
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
      // categoryList[index].selected == true 이거나 categoryList[index].selected 이거나 둘 중 하나로 통일 !
      if (categoryList[index].selected == true) {
        setCategoryUnselected(index);
      } else {
        setCategorySelected(index);
        setOtherCategoryUnselected(index);
      }
    });
  }

  List<ButtonProperties> typeList = [
    ButtonProperties(label: '발달장애'),
    ButtonProperties(label: '뇌병변장애'),
  ];

  // 타입 select 변경하는 거 함수로 하나로 묶기 !
  void _onClickType(int index) {
    HapticFeedback.lightImpact(); // 약한 진동
    setState(() {
      if (typeList[index].selected == true) {
        setTypeUnselected(index);
      } else {
        setTypeSelected(index);
      }
    });
  }

  Future<bool> _onClickBackKey() async {
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
        // 추후에 에러가 발생할 가능성이 다분하다 !
        if (_type == null) {
          _type = [typeList[i].label];
        } else {
          _type!.add(typeList[i].label);
        }
      }
    }
    widget.categories.type = _type;

    // 문맥 파악 용이를 위해 엔터를 함께 써서 단락을 구분하자 !
    if (widget.categories.category == null) {
      // Get.snackbar('카테고리 선택 실패!', '게시판 종류를 선택해주세요',
      //     backgroundColor: Colors.white);
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                semanticLabel: "카테고리 선택을 실패했습니다. 게시판 종류를 선택해주세요.",
                content: const Text('게시판 종류를 선택해주세요',
                    semanticsLabel: '게시판 종류를 선택해주세요',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w600,
                    )),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: constants.mainColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('확인',
                          semanticsLabel: '확인',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )))
                ]);
          });
    } else {
      Navigator.pop(context, widget.categories);
      return false;
    }
  }

  int? indexBackKey;

  @override
  Widget build(BuildContext context) {
    // _firstMainScreenProvider  = Provider.of.<FirstMainScreenProvider>(context);
    return WillPopScope(
        onWillPop: () {
          return _onClickBackKey();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: constants.mainColor,
            title: Text(widget.title,
                semanticsLabel: widget.title,
                style: const TextStyle(
                    fontFamily: 'NanumGothic', fontWeight: FontWeight.w600)),
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
                  // Get.snackbar('카테고리 선택 실패!', '게시판 종류를 선택해주세요',
                  //     backgroundColor: Colors.white);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            semanticLabel: "카테고리 선택을 실패했습니다. 게시판 종류를 선택해주세요.",
                            content: const Text('게시판 종류를 선택해주세요',
                                semanticsLabel: '게시판 종류를 선택해주세요',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: constants.mainColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('확인',
                                      semanticsLabel: '확인',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w600,
                                      )))
                            ]);
                      });
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
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('게시판 종류',
                                semanticsLabel: '게시판 종류',
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
                                    indexBackKey = index;
                                    return ElevatedButton(
                                        onPressed: () =>
                                            _onClickCategory(index),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: categoryList[index]
                                              .backgroundColor,
                                        ),
                                        child: Text(categoryList[index].label,
                                            semanticsLabel:
                                                categoryList[index].label,
                                            style: TextStyle(
                                                color: categoryList[index]
                                                    .fontColor,
                                                fontFamily: 'NanumGothic',
                                                fontWeight: FontWeight.w600)));
                                  }))
                        ])),
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('장애 유형',
                                semanticsLabel: '장애 유형',
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
                                      semanticsLabel: typeList[index].label,
                                      style: TextStyle(
                                          color: typeList[index].fontColor,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w600),
                                    ));
                              }))
                    ])),
                  ]))),
        ));
  }
}
