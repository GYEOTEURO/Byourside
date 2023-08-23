import 'package:byourside/model/authenticate/nickname_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NicknameSection extends StatelessWidget {
  final NicknameController _nicknameController = Get.put(NicknameController());

  NicknameSection({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NicknameController>(() => NicknameController(), fenix: true);

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
              controller: _nicknameController.controller,
              decoration: const InputDecoration(
                labelText: '닉네임을 입력하세요',
                hintText: '(예: 홍길동) ',
              ),
              autofocus: true,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _nicknameController.checkNicknameExist(context);
              _nicknameController.isNicknameChecked.value = true;
            },
            child: const Text('중복확인'),
          ),
          Obx(() => Text(
                _nicknameController.isNicknameChecked.value
                    ? _nicknameController.nickNameExist.value
                        ? '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'
                        : '사용 가능한 닉네임입니다.'
                    : '',
                style: TextStyle(
                  color: _nicknameController.nickNameExist.value ? Colors.red : Colors.green,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }
}
