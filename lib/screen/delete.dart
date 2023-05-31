import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/db_set.dart';

class Delete extends StatefulWidget {
  Delete(
      {super.key,
      required this.collectionName,
      required this.documentID,
      this.commentID=Null});
  final Color primaryColor = const Color(0xFF045558);
  final String collectionName;
  final String documentID;
  var commentID;

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    var type = widget.commentID.isNull?'글':'댓글';

    return OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
            ),
            child: Text('삭제',
                semanticsLabel: '$type 삭제',
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
                                '$type을 삭제하시겠습니까? 삭제를 원하시면 하단 왼쪽의 삭제 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                            title: Text('$type을 삭제하시겠습니까?',
                                semanticsLabel:
                                    '$type을 삭제하시겠습니까? 삭제를 원하시면 하단 왼쪽의 삭제 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.w600,
                                )),
                            actions: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: widget.primaryColor,
                                        ),
                                        onPressed: () {
                                          HapticFeedback.lightImpact(); // 약한 진동
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, '/', (_) => false);
                                          widget.commentID.isNull?
                                            DBSet.deletePost(widget.collectionName, widget.documentID):
                                            DBSet.deleteComment(widget.collectionName, widget.documentID, widget.commentID);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('삭제',
                                            semanticsLabel: '삭제',
                                            style: TextStyle(
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
                                        child: const Text('취소',
                                            semanticsLabel: '취소',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'NanumGothic',
                                              fontWeight: FontWeight.w600,
                                            )))
                                  ])
                            ]);
                  });
            },
          );
  }}