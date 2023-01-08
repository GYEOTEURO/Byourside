import 'package:flutter/material.dart';
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
    "상업적 광고 및 판매 사용자입니다."];

  @override
  Widget build(BuildContext context) {
    String _declaration = _decList[0];
    final TextEditingController _nickname = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
            semanticsLabel: widget.title,
            style: TextStyle(
                fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
                controller: _nickname,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "신고할 닉네임을 입력해주세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1),
            ))),
            StatefulBuilder(
                      builder: (context, setState) {
                      return Column(
                        children: _decList.map((e) =>
                          new RadioListTile(
                            title: Text(
                              e,
                              semanticsLabel: e,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w600,
                            )),
                            value: e,
                            groupValue: _declaration,
                            onChanged: (String? value){
                              setState(() {
                                _declaration = value!;
                              });
                            }
                          )).toList()  
            );}),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    foregroundColor: Colors.white,
                ),
                onPressed: () {
                  //DBSet.declaration('user', _declaration, _nickname.text);
                  showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        content: Text(
                          '신고되었습니다.',
                          semanticsLabel: '신고되었습니다.',
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
                            child: Text(
                              '확인',
                              semanticsLabel: '확인',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w600,
                              ))
                            )
                        ]);
                  });
                }, 
                child: Text(
                  '신고',
                  semanticsLabel: '신고',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w600,
                  ))
            ),
          ])
        )
      ) 
    );
  }
}
