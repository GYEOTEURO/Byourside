import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NicknameSection extends StatefulWidget {
  const NicknameSection({super.key});

  @override
  NicknameSectionState createState() => NicknameSectionState();
}

class NicknameSectionState extends State<NicknameSection> {
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

  //TODO: 다른 파일에서도 쓸 수 있게 해당 위젯의 deviceWidth, deviceHeight 받아서 비율 곱해서 반환하게
  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }

  Widget buildNicknameContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: buildNicknameTextField(),
              ),
              SizedBox(width: getRelativeWidth(0.05)),
              buildCheckNicknameButton(context),
            ],
          ),
          SizedBox(height: getRelativeHeight(0.01)),
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
        width: getRelativeWidth(0.66),
        height: getRelativeHeight(0.07),
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
            labelStyle: TextStyle(
              color: colors.textColor,
              fontSize: getRelativeWidth(0.036),
              fontFamily: fonts.font,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(getRelativeWidth(0.087)),
              borderSide: BorderSide.none,
            ),
          ),
          autofocus: true,
        ),
      ),
    );
  }

  void handleNicknameCheckButtonPressed(BuildContext context) async {
    await _nicknameController.checkNicknameExist(context);
    _nicknameController.isNicknameChecked.value = true;

    _nicknameController.controller.addListener(() {
    });
  }


  Widget buildCheckNicknameButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
       handleNicknameCheckButtonPressed(context);
      },
      child: Container(
        width: getRelativeWidth(0.26),
        height: getRelativeHeight(0.07),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getRelativeWidth(0.2)),
          color: const Color(0xffffc700),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '중복확인',
              style: TextStyle(
                fontSize: getRelativeWidth(0.036),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildNicknameCheckResultText() {
    return Obx(() {
      var isNicknameChecked = _nicknameController.isNicknameChecked.value;
      var nickNameExist = _nicknameController.nickNameExist.value;
      var nickname = _nicknameController.controller.text;

      String message = '';

      if (!isNicknameChecked) {
        message = ''; // 아무 메시지도 표시하지 않음
      } 
      if (nickname.isEmpty) {
        message = '닉네임을 입력하세요';
      } else {
        message = nickNameExist
            ? '이미 사용하고 있는 닉네임입니다'
            : '사용 가능한 닉네임입니다';
      }

      return Text(
        message,
        style: TextStyle(
          color: nickname.isEmpty || nickNameExist ? Colors.red : Colors.green,
          fontFamily: 'NanumGothic',
          fontSize: getRelativeWidth(0.036),
          fontWeight: FontWeight.w400,
        ),
      );
    });
  }

}
