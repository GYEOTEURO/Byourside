import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/widget/authenticate/setup/explain_text.dart';


class AgeSection extends StatefulWidget {
  final String selectedType;
  final TextEditingController controller;

  const AgeSection({
    Key? key,
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
        var mediaQuery = MediaQuery.of(context);
        _deviceWidth = mediaQuery.size.width;
        _deviceHeight = mediaQuery.size.height;
      });
    });
  }

  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }

  Widget buildAgeTextField() {
    return Semantics(
      container: true,
      textField: true,
      label: text.askUserAge,
      hint: text.exampleUserAge,
      child: SizedBox(
        width: getRelativeWidth(0.46),
        height: getRelativeHeight(0.06),
        child: TextFormField(
          onTap: _onTextFieldTap,
          controller: widget.controller,
          maxLines: 1,
          decoration: _buildInputDecoration(),
          textAlign: TextAlign.center,
          autofocus: true,
          inputFormatters: _getInputFormatters(),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  void _onTextFieldTap() {
    HapticFeedback.lightImpact();
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      hintText: text.hintUserAge,
      fillColor: colors.bgrColor,
      hintStyle: TextStyle(
        color: colors.textColor,
        fontSize: getRelativeWidth(0.038),
        fontFamily: fonts.font,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(getRelativeWidth(0.087)),
        borderSide: BorderSide.none,
      ),
      suffix: _buildSuffixContainer(),
      contentPadding: EdgeInsets.symmetric(vertical: getRelativeWidth(0.02), horizontal: getRelativeWidth(0.04)), 
    );
  }

  Widget _buildSuffixContainer() {
    return Container(
      alignment: Alignment.centerRight,
      width: getRelativeWidth(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeHeight(0.005)),
        child:Text(
          text.ageUnit,
          style: TextStyle(
            color: colors.textColor,
            fontSize: getRelativeWidth(0.036),
            fontFamily: fonts.font,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplainText(
            text: widget.selectedType == text.protector
                ? text.requestChildAge
                : text.requestAge,
            width: getRelativeWidth(0.039),
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          Align(
            alignment: Alignment.centerLeft,
            child: buildAgeTextField(),
          ),
        ],
      ),
    );
  }
}
