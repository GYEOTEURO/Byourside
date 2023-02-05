import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/db_set.dart';

class Declaration extends StatefulWidget {
  Declaration(
      {super.key,
      required this.decList,
      required this.collectionType,
      required this.id});
  final Color primaryColor = Color(0xFF045558);
  final List<String> decList;
  final String collectionType;
  final String id;

  @override
  State<Declaration> createState() => _DeclarationState();
}

class _DeclarationState extends State<Declaration> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String _declaration = widget.decList[0];

    return OutlinedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
      child: Text('신고',
          semanticsLabel: '신고',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w600,
          )),
      onPressed: () {
        HapticFeedback.lightImpact(); // 약한 진동
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                      scrollable: true,
                      semanticLabel:
                          '신고 사유를 알려주세요. 신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다. 신고 사유를 선택 후 하단 왼쪽의 신고 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                      title: Text(
                          '신고 사유를 알려주세요.\n신고 사유에 맞지 않는 신고일 경우,\n해당 신고는 처리되지 않습니다.',
                          semanticsLabel:
                              '신고 사유를 알려주세요. 신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )),
                      content: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: widget.decList
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
                              .toList(),
                        );
                      }),
                      actions: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.primaryColor,
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact(); // 약한 진동
                                    DBSet.declaration(widget.collectionType,
                                        _declaration, widget.id);
                                    Navigator.pop(context);
                                  },
                                  child: Text('신고',
                                      semanticsLabel: '신고',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w600,
                                      ))),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.primaryColor,
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact(); // 약한 진동
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소',
                                      semanticsLabel: '취소',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.w600,
                                      )))
                            ])
                      ]);
            });
      },
    );
  }
}
