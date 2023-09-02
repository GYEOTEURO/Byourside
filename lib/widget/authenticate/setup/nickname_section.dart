import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:get/get.dart';

class NicknameSection extends StatefulWidget {
  NicknameSection({super.key});

  @override
  _NicknameSectionState createState() => _NicknameSectionState();
}

class _NicknameSectionState extends State<NicknameSection> {
  final NicknameController _nicknameController = Get.put(NicknameController());
  double _deviceWidth = 0;
  double _deviceHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _deviceWidth = MediaQuery.of(context).size.width;
        _deviceHeight = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildNicknameContent(context);
  }

  Widget buildNicknameContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
          children: [
            Expanded(
                child: buildNicknameTextField(),
              ),
              const SizedBox(width: 16), 
              buildCheckNicknameButton(context),
            ],
          ),
          const SizedBox(height: 10), 
          buildNicknameCheckResultText(),
        ],
      ),
    );
  }

  Widget buildNicknameTextField() {
    return Semantics(
      container: true,
      textField: true,
      label: '닉네임을 입력하세요.',
      hint: '(예: 홍길동)',
      child: SizedBox(
        width: _deviceWidth * 0.66,
        height: _deviceHeight * 0.07,
        child: TextFormField(
          onTap: () {
            HapticFeedback.lightImpact();
          },
          controller: _nicknameController.controller,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: '닉네임을 입력하세요',
            fillColor: colors.bgrColor,
            filled: true,
            hintText: '(예: 홍길동) ',
            labelStyle: const TextStyle(
              color: colors.textColor,
              fontSize: 12,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
          ),
          autofocus: true,
        ),
      ),
    );
  }

  Widget buildCheckNicknameButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _nicknameController.checkNicknameExist(context);
        _nicknameController.isNicknameChecked.value = true;
      },
      child: Container(
        width: _deviceWidth * 0.26,
        height: _deviceHeight * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(69),
          color: const Color(0xffffc700),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '중복확인',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700, // 오타 수정: FontWeith -> FontWeight
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNicknameCheckResultText() {
    return Obx(() => Text(
          _nicknameController.isNicknameChecked.value
              ? _nicknameController.nickNameExist.value
                  ? '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.'
                  : '사용 가능한 닉네임입니다.'
              : '',
          style: TextStyle(
            color: _nicknameController.nickNameExist.value ? Colors.red : Colors.green,
            fontFamily: 'NanumGothic',
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ));
  }
}
