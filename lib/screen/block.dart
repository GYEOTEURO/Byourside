import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/db_set.dart';

class Block extends StatefulWidget {
  Block({super.key, required this.nickname, required this.collectionType});
  final Color primaryColor = Color(0xFF045558);
  final String nickname;
  final String collectionType;

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: widget.collectionType == 'chat'
          ? ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 1.5),
              foregroundColor: widget.primaryColor,
              backgroundColor: Colors.grey[700])
          : ElevatedButton.styleFrom(
              side: BorderSide(color: widget.primaryColor, width: 1.5),
              foregroundColor: widget.primaryColor,
            ),
      child: widget.collectionType == 'chat'
          ? Text('차단',
              semanticsLabel: '차단',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ))
          : Text('차단',
              semanticsLabel: '차단',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 45, 45),
                fontSize: 14,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              )),
      onPressed: () {
        HapticFeedback.lightImpact(); // 약한 진동
        showDialog(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: AlertDialog(
                      semanticLabel:
                          '사용자를 차단하시겠습니까? 사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다. 차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다. 차단을 원하시면 하단 왼쪽의 차단 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                      title: Text(
                          '사용자를 차단하시겠습니까?\n사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다.\n차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다.',
                          semanticsLabel:
                              '사용자를 차단하시겠습니까? 사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다. 차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다. 차단을 원하시면 하단 왼쪽의 차단 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )),
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
                                    if (widget.collectionType == 'post') {
                                      Navigator.pushNamed(context, '/');
                                    } else {
                                      Navigator.pop(context);
                                    }
                                    DBSet.addBlock(user!.uid, widget.nickname);
                                  },
                                  child: Text('차단',
                                      semanticsLabel: '차단',
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
                      ]));
            });
      },
    );
  }
}
