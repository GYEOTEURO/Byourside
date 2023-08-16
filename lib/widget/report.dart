import 'package:byourside/constants/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/save_data.dart';

class Report extends StatefulWidget {
  const Report(
      {super.key,
      required this.reportReasonList,
      required this.collectionType,
      required this.id});
  final List<String> reportReasonList;
  final String collectionType;
  final String id;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    String reportReason = widget.reportReasonList[0];

    return OutlinedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
      child: const Text('신고',
          semanticsLabel: '신고',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: constants.font,
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
                  title: const Text(
                      '신고 사유를 알려주세요.\n신고 사유에 맞지 않는 신고일 경우,\n해당 신고는 처리되지 않습니다.',
                      semanticsLabel:
                          '신고 사유를 알려주세요. 신고 사유에 맞지 않는 신고일 경우, 해당 신고는 처리되지 않습니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w600,
                      )),
                  content: StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: widget.reportReasonList
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
                              onChanged: (String? value) {
                                setState(() {
                                  reportReason = value!;
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
                                backgroundColor: constants.mainColor,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                saveData.report(widget.collectionType,
                                    reportReason, widget.id);
                                Navigator.pop(context);
                              },
                              child: const Text('신고',
                                  semanticsLabel: '신고',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: constants.font,
                                    fontWeight: FontWeight.w600,
                                  ))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: constants.mainColor,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                Navigator.pop(context);
                              },
                              child: const Text('취소',
                                  semanticsLabel: '취소',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: constants.font,
                                    fontWeight: FontWeight.w600,
                                  )))
                        ])
                  ]);
            });
      },
    );
  }
}
