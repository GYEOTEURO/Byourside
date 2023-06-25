import 'package:byourside/magic_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/save_data.dart';

class BlockUser extends StatefulWidget {
  const BlockUser({super.key, required this.nickname, required this.collectionType});
  final Color primaryColor = mainColor;
  final String nickname;
  final String collectionType;

  @override
  State<BlockUser> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
      child: const Text('차단',
          semanticsLabel: '차단',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: font,
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
                          '사용자를 차단하시겠습니까? 사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다. 차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다. 차단을 원하시면 하단 왼쪽의 차단 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                      title: const Text(
                          '사용자를 차단하시겠습니까?\n사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다.\n차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다.',
                          semanticsLabel:
                              '사용자를 차단하시겠습니까? 사용자를 차단하면, 해당 사용자가 작성한 글/댓글/채팅이 모두 보이지 않습니다. 차단 목록 확인과 관리는 마이페이지의 사용자 차단하기에서 확인하실 수 있습니다. 차단을 원하시면 하단 왼쪽의 차단 버튼을 눌러주세요. 취소를 원하시면 하단 오른쪽의 취소 버튼을 눌러주세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: font,
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/', (_) => false);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                    saveData.addBlock(user!.uid, widget.nickname);
                                  },
                                  child: const Text('차단',
                                      semanticsLabel: '차단',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: font,
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
                                        fontFamily: font,
                                        fontWeight: FontWeight.w600,
                                      )))
                            ])
                      ]);
            });
      },
    );
  }
}
