import 'package:byourside/constants/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/save_data.dart';

class MyReport extends StatefulWidget {
  const MyReport({Key? key}) : super(key: key);
  final Color primaryColor = constants.mainColor;
  final String title = '사용자 신고';

  @override
  State<MyReport> createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> {
  final SaveData saveData = SaveData();
  final List<String> _reportReasonList = [
    '불법 정보를 게시했습니다.',
    '음란물을 게시했습니다.',
    '스팸홍보/도배글을 게시했습니다.',
    '욕설/비하/혐오/차별적 표현을 사용했습니다.',
    '청소년에게 유해한 내용을 게시했습니다.',
    '사칭/사기 사용자입니다.',
    '상업적 광고 및 판매 사용자입니다.'
  ];

  final TextEditingController _nickname = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String reportReason = _reportReasonList[0];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: const TextStyle(
                fontFamily: constants.font, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF045558),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                semanticLabel: '뒤로 가기', color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
              key: _formkey,
              child: Column(children: [
                Semantics(
                    label: '신고할 닉네임 입력',
                    child: TextFormField(
                        controller: _nickname,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '신고할 닉네임은 비어있을 수 없습니다';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          semanticCounterText: '신고할 닉네임 입력',
                          labelText: '신고할 닉네임을 입력해주세요.',
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF045558)),
                          ),
                          labelStyle: TextStyle(color: Color(0xFF045558)),
                        ))),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: const Text(
                        '신고 사유를 알려주세요.\n신고 사유에 맞지 않는 신고일 경우,\n해당 신고는 처리되지 않습니다.',
                        semanticsLabel:
                            '신고 사유를 알려주세요.신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: constants.font,
                          fontWeight: FontWeight.w600,
                        ))),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
                      children: _reportReasonList
                          .map((e) => RadioListTile(
                              title: Text(e,
                                  semanticsLabel: e,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: constants.font,
                                    fontWeight: FontWeight.w600,
                                  )),
                              value: e,
                              groupValue: reportReason,
                              activeColor: const Color(0xFF045558),
                              onChanged: (String? value) {
                                setState(() {
                                  reportReason = value!;
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
              saveData.report('user', reportReason, _nickname.text);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel:
                            '정상적으로 신고되었습니다. 이전 화면으로 이동하려면 확인 버튼을 누르세요.',
                        content: const Text('정상적으로 신고되었습니다.',
                            semanticsLabel: '정상적으로 신고되었습니다.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: constants.font,
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
                              child: const Text('확인',
                                  semanticsLabel: '확인',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: constants.font,
                                    fontWeight: FontWeight.w600,
                                  )))
                        ]);
                  });
            }
          },
          child: const Text('신고',
              semanticsLabel: '신고',
              style: TextStyle(
                fontSize: 14,
                fontFamily: constants.font,
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
