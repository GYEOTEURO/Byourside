import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NanumPostCategory extends StatefulWidget {
  const NanumPostCategory(
      {Key? key, required this.primaryColor, required this.title, this.preType})
      : super(key: key);
  final Color primaryColor;
  final String title;
  final List<String>? preType;

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
  List<String>? _type = [];

  List<ButtonProperties> typeList = [
    ButtonProperties(label: '발달장애'),
    ButtonProperties(label: '뇌병변장애'),
  ];

  @override
  void initState() {
    print(widget.preType);
    // TODO: implement initState
    if (widget.preType != null) {
      for (int j = 0; j < widget.preType!.length; j++) {
        for (int i = 0; i < 2; i++) {
          if (typeList[i].label == widget.preType![j]) {
            typeList[i].selected = true;
            typeList[i].backgroundColor = const Color(0xFF045558);
            typeList[i].fontColor = Colors.white;
          }
        }
      }
    }
    super.initState();
  }

  void _onClickType(int index) {
    HapticFeedback.lightImpact(); // 약한 진동
    setState(() {
      if (typeList[index].selected) {
        typeList[index].selected = false;
        typeList[index].backgroundColor = Colors.white;
        typeList[index].fontColor = Colors.black;
      } else {
        // _type = typeList[index].label;
        typeList[index].selected = true;
        typeList[index].backgroundColor = const Color(0xFF045558);
        typeList[index].fontColor = Colors.white;
        // 나머지 버튼들은 비활성화
        // for (int i = 0; i < 2; i++) {
        //   if (i == index) {
        //     continue;
        //   } else {
        //     typeList[i].selected = false;
        //     typeList[i].backgroundColor = Colors.white;
        //     typeList[i].fontColor = Colors.black;
        //   }
        // }
      }
    });
  }

  Future<bool> _onClickBackKey() async {
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
    Navigator.pop(context, _type);
    return false;
  }

  int? indexBackKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return _onClickBackKey();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: widget.primaryColor,
            title: Text(
              widget.title,
              semanticsLabel: widget.title,
              style: const TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
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
                Navigator.pop(context, _type);
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
                                indexBackKey = index;
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
