import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/db_set.dart';

class Declaration extends StatefulWidget {
  Declaration({Key? key}) : super(key: key);
  final Color primaryColor = Color(0xFF045558);
  final String title = "사용자 신고";

  @override
  State<Declaration> createState() => _DeclarationState();
}

class _DeclarationState extends State<Declaration> {
  List<String> _decList = [
    "불법 정보를 게시했습니다.",
    "음란물을 게시했습니다.",
    "스팸홍보/도배글을 게시했습니다.",
    "욕설/비하/혐오/차별적 표현을 사용했습니다.",
    "청소년에게 유해한 내용을 게시했습니다.",
    "사칭/사기 사용자입니다.",
    "상업적 광고 및 판매 사용자입니다."
  ];

  final TextEditingController _nickname = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _declaration = _decList[0];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF045558),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                semanticLabel: "뒤로 가기", color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Form(
              key: _formkey,
              child: Column(children: [
                Semantics(
                    label: "신고할 닉네임 입력",
                    child: TextFormField(
                        controller: _nickname,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "신고할 닉네임은 비어있을 수 없습니다";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          semanticCounterText: "신고할 닉네임 입력",
                          labelText: "신고할 닉네임을 입력해주세요.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF045558)),
                          ),
                          labelStyle: TextStyle(color: Color(0xFF045558)),
                        ))),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                        '신고 사유를 알려주세요.\n신고 사유에 맞지 않는 신고일 경우,\n해당 신고는 처리되지 않습니다.',
                        semanticsLabel:
                            '신고 사유를 알려주세요.신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ))),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                      children: _decList
                          .map((e) => new RadioListTile(
                              title: Text(e,
                                  semanticsLabel: e,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w600,
                                  )),
                              value: e,
                              groupValue: _declaration,
                              onChanged: (String? value) {
                                setState(() {
                                  _declaration = value!;
                                });
                              }))
                          .toList());
                }),
              ]))),
      floatingActionButton: FloatingActionButton(
          backgroundColor: widget.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formkey.currentState!.validate()) {
              DBSet.declaration('user', _declaration, _nickname.text);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel:
                            "정상적으로 신고되었습니다. 이전 화면으로 이동하려면 확인 버튼을 누르세요.",
                        content: Text('정상적으로 신고되었습니다.',
                            semanticsLabel: '정상적으로 신고되었습니다.',
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
                                HapticFeedback.lightImpact(); // 약한 진동
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
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
            }
          },
          child: Text('신고',
              semanticsLabel: '신고',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
