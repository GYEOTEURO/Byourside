import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostCategory extends StatefulWidget {
  const PostCategory(
      {Key? key, required this.primaryColor, required this.title})
      : super(key: key);
  final Color primaryColor;
  final String title;

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
  String? _type = null;

  List<ButtonProperties> categoryList = [
    ButtonProperties(label: '자유게시판'),
    ButtonProperties(label: '병원/센터 후기'),
    ButtonProperties(label: '복지/혜택'),
    ButtonProperties(label: '법률/제도'),
    ButtonProperties(label: '교육/세미나'),
    ButtonProperties(label: '초기 증상 발견/생활 속 Tip'),
  ];

  void _onClickCategory(int index) {
    setState(() {
      if (categoryList[index].selected) {
        categoryList[index].selected = false;
        categoryList[index].backgroundColor = Colors.white;
        categoryList[index].fontColor = Colors.black;
      } else {
        _category = categoryList[index].label;
        categoryList[index].selected = true;
        categoryList[index].backgroundColor = Color(0xFF045558);
        categoryList[index].fontColor = Colors.white;
      }
    });
  }

  List<ButtonProperties> typeList = [
    ButtonProperties(label: '발달장애'),
    ButtonProperties(label: '뇌병변장애'),
  ];

  void _onClickType(int index) {
    setState(() {
      if (typeList[index].selected) {
        typeList[index].selected = false;
        typeList[index].backgroundColor = Colors.white;
        typeList[index].fontColor = Colors.black;
      } else {
        _type = typeList[index].label;
        typeList[index].selected = true;
        typeList[index].backgroundColor = Color(0xFF045558);
        typeList[index].fontColor = Colors.white;
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
            // pop 할 때, 파라미터를 두 개를 어떻게 넘기는 지 리스트로 넣는 수 밖에 없는 건지 몰라서 일단 넘기는 거 아직...
            Navigator.pop(
                context,
                PostPage(
                  primaryColor: widget.primaryColor,
                  title: widget.title,
                  category: _category,
                  type: _type,
                ));
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Center(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Text('게시판 종류',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)))),
        Row(children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () => _onClickCategory(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: categoryList[index].backgroundColor,
                        ),
                        child: Text(categoryList[index].label,
                            style: TextStyle(
                                color: categoryList[index].fontColor)));
                  }))
        ]),
        const Center(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Text('장애 유형',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)))),
        Row(children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: typeList.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () => _onClickType(index),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: typeList[index].backgroundColor),
                        child: Text(
                          typeList[index].label,
                          style: TextStyle(color: typeList[index].fontColor),
                        ));
                  }))
        ]),
      ])),
    );
  }
}
