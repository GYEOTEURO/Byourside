import 'package:flutter/material.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/auth_icons.dart' as auth_icons;

class UserTypeButton extends StatelessWidget {
  final String userType;
  final bool isSelected;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double font;

  const UserTypeButton({super.key, 
    required this.userType,
    required this.isSelected,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.font
  });
  
@override
Widget build(BuildContext context) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || isSelected) {
              return colors.midPrimaryColor; 
            }
            return colors.bgrColor; 
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || isSelected) {
              return const BorderSide(color: colors.midPrimaryColor,); 
            }
            return const BorderSide(color: colors.bgrColor,); 
          },
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            auth_icons.iconMap[userType] ?? const SizedBox(),
            if (userType != text.noneType) 
              SizedBox(height: height * 0.06),
            Text(
              userType == text.noneType ? text.haveNoneType : userType,
              style: TextStyle(
                fontSize: font,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}