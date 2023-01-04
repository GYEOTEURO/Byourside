import 'package:byourside/screen/nanum/nanumPostPage.dart';
import 'package:byourside/screen/ondo/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NanumPostCategory extends StatefulWidget {
  const NanumPostCategory(
      {Key? key, required this.primaryColor, required this.title, this.preType})
      : super(key: key);
  final Color primaryColor;
  final String title;
  final String? preType;

  @override
  State<NanumPostCategory> createState() => _NanumPostCategoryState();
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

class _NanumPostCategoryState extends State<NanumPostCategory> {
  // String? _category = null;
  String? _type = null;

  List<ButtonProperties> typeList = [
    ButtonProperties(label: '발달장애'),
    ButtonProperties(label: '뇌병변장애'),
  ];

  @override
  void initState() {
    print(widget.preType);
    // TODO: implement initState
    for (int i = 0; i < 2; i++) {
      if (typeList[i].label == widget.preType) {
        typeList[i].selected = true;
        typeList[i].backgroundColor = Color(0xFF045558);
        typeList[i].fontColor = Colors.white;
      }
    }
    super.initState();
  }

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
        // 나머지 버튼들은 비활성화
        for (int i = 0; i < 2; i++) {
          if (i == index) {
            continue;
          } else {
            typeList[i].selected = false;
            typeList[i].backgroundColor = Colors.white;
            typeList[i].fontColor = Colors.black;
          }
        }
      }
    });
  }

  void _initPreType() {
    setState(() {
      for (int i = 0; i < 2; i++) {
        if (typeList[i].label == widget.preType) {
          typeList[i].selected = true;
          typeList[i].backgroundColor = Color(0xFF045558);
          typeList[i].fontColor = Colors.white;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // _initPreType();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, _type);
          },
          icon: const Icon(Icons.arrow_back),
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
                        child: Text('장애 유형',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)))),
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
                                      color: typeList[index].fontColor),
                                ));
                          }))
                ])),
              ]))),
    );
  }
}
