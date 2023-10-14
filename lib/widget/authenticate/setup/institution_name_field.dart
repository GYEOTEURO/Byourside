import 'package:flutter/material.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

class InstitutionNameTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onTap;

  const InstitutionNameTextField({
    Key? key,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  InstitutionNameTextFieldState createState() => InstitutionNameTextFieldState();
}

class InstitutionNameTextFieldState extends State<InstitutionNameTextField> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.institutionNameLabel,
            style: TextStyle(
              color: colors.textColor,
              fontSize: getRelativeWidth(0.036),
              fontFamily: fonts.font,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: getRelativeHeight(0.02)),
          SizedBox(
            width: getRelativeWidth(0.46),
            height: getRelativeHeight(0.06),
            child: TextFormField(
              controller: widget.controller,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.bgrColor,
                hintText: text.institutionNameHint,
                hintStyle: TextStyle(
                  color: colors.textColor,
                  fontSize: getRelativeWidth(0.04),
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getRelativeWidth(0.087)),
                  borderSide: BorderSide.none,
                ),
              ),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }
}
