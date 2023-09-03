import 'package:byourside/widget/authenticate/setup/explain_text.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeSection extends StatefulWidget {
  final String selectedType;
  final TextEditingController controller;

  const AgeSection({Key? key, 
    required this.selectedType,
    required this.controller,   
  }) : super(key: key);

  @override
  AgeSectionState createState() => AgeSectionState();
}

class AgeSectionState extends State<AgeSection> {
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

  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplainText(
            text: widget.selectedType == '장애 아동 보호자' ? '아동의 나이를 입력해 주세요' : '나이를 입력해 주세요',
            width: getRelativeWidth(0.04),
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: buildAgeTextField(),
          ),
        ],
      ),
    );
  }
  Widget buildAgeTextField() {
    return Semantics(
      container: true,
      textField: true,
      label: '몇 년생인지 입력하세요.',
      hint: '(예: 1990)',
      child: SizedBox(
        width: getRelativeWidth(0.46),
        height: getRelativeHeight(0.07),
        child: TextFormField(
          onTap: () {
            HapticFeedback.lightImpact();
          },
          controller: widget.controller,
          maxLines: 1,
          decoration: InputDecoration(
            filled: true,
            hintText: '1990', 
            fillColor: colors.bgrColor,
            hintStyle: TextStyle(
              color: colors.textColor, 
              fontSize: getRelativeWidth(0.036),
              fontFamily: fonts.font,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(getRelativeWidth(0.087)),
              borderSide: BorderSide.none,
            ),
            suffix: Container(
              alignment: Alignment.centerRight, 
              width: getRelativeWidth(0.1), 
              child: Text(
                '년생',
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: getRelativeWidth(0.036),
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(getRelativeWidth(0.04)), // 오른쪽 패딩 추가
          ),
          textAlign: TextAlign.center, // '1990' 텍스트를 중앙 정렬
          autofocus: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
