import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/screen/authenticate/controller/nickname_controller.dart';


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
    _nicknameController.controller.addListener(() {
      // var newNickname = _nicknameController.controller.text;
      // var currentNickNameExist = _nicknameController.nickNameExist.value;
      // if (newNickname.isNotEmpty && !currentNickNameExist) {
      if(_nicknameController.isNicknameChecked.value == true) {
        _nicknameController.checkNicknameExist(context);
      }
        // _nicknameController.isNicknameChanged.value = true;
      // }
    });

    return Semantics(
      container: true,
      textField: true,
      label: text.askNickName,
      hint: text.hintNickName,
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
            labelText: text.askNickName,
            fillColor: colors.bgrColor,
            filled: true,
            hintText: text.hintNickName,
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
    // _nicknameController.isNicknameChanged.value = false;

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
              text.verifyDuplicate,
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
      var nickName = _nicknameController.controller.text;
      // var isNicknameChanged = _nicknameController.isNicknameChanged.value;
        print(nickName);
      String message = text.none;
      if (!isNicknameChecked) {
        message = text.none; 
      } 
      else if (nickName.isEmpty) {

        message = text.askNickName;
      }
      // else if (isNicknameChanged) {
      //   message = text.askVerify;
      // }
      else {
        message = nickNameExist
            ? text.usedNickName
            : text.unusedNickName;
      }
      
      return Text(
        message,
        style: TextStyle(
          color: nickName.isEmpty || nickNameExist ? Colors.red : Colors.green,
          fontFamily: fonts.font,
          fontSize: getRelativeWidth(0.036),
          fontWeight: FontWeight.w400,
        ),
      );
    });
  }

}
