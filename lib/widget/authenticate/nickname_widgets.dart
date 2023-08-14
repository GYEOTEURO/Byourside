
import 'package:byourside/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NicknameSection extends StatefulWidget {
  const NicknameSection({super.key});

  @override
  _NicknameSectionState createState() => _NicknameSectionState();
}

class _NicknameSectionState extends State<NicknameSection> {
  final TextEditingController _nickname = TextEditingController();
  bool isNicknameChecked = false;
  bool nickNameExist = false;

  Future<void> checkNicknameExist(BuildContext context, String nickname) async {
    var collection = FirebaseFirestore.instance.collection('userInfo');
    var querySnapshot = await collection.where('nickname', isEqualTo: nickname).get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        nickNameExist = true; 
      });
    } else {
      setState(() {
        nickNameExist = false;
      });
    }
  }

  Future<void> showAlertDialog(BuildContext context, String contentText) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          message: contentText,
          buttonText: '확인',
        );
      },
    );
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Semantics(
            container: true,
            textField: true,
            label: '닉네임을 입력하세요.',
            hint: '(예: 홍길동)',
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: '닉네임을 입력하세요',
                hintText: '(예: 홍길동) ',
              ),
              autofocus: true,
              controller: _nickname,
              validator: (value) {
                // ... 닉네임 검증 로직 ...
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              checkNicknameExist(context, _nickname.text);
              setState(() {
                isNicknameChecked = true;
              });
            },
            child: const Text('중복확인'),
          ),
          Text(
            isNicknameChecked
                ? nickNameExist
                    ? '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'
                    : '사용가능한 닉네임입니다.'
                : '',
            style: TextStyle(
              color: nickNameExist ? Colors.red : Colors.green,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}