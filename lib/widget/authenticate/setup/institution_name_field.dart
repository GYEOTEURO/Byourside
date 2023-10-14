import 'package:flutter/material.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

class InstitutionNameTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onTap;

  const InstitutionNameTextField({super.key, required this.controller, required this.onTap});

  @override
  InstitutionNameTextFieldState createState() => InstitutionNameTextFieldState();
}

class InstitutionNameTextFieldState extends State<InstitutionNameTextField> {
  double deviceWidth = 0;
  double deviceHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        var mediaQuery = MediaQuery.of(context);
        deviceWidth = mediaQuery.size.width;
        deviceHeight = mediaQuery.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.66,
      height: deviceHeight * 0.07,
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: text.institutionNameLabel,
          fillColor: colors.bgrColor,
          filled: true,
          hintText: text.institutionNameHint,
          labelStyle: TextStyle(
            color: colors.textColor,
            fontSize: deviceWidth * 0.036,
            fontFamily: fonts.font,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(deviceWidth * 0.087),
            borderSide: BorderSide.none,
          ),
        ),
        autofocus: false,
      ),
    );
  }
}
