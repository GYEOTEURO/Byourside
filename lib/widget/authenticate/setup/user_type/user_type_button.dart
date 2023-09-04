import 'package:flutter/material.dart';
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
              return const BorderSide(color: colors.midPrimaryColor,); // Change border color to #FFC700
            }
            return const BorderSide(color: colors.bgrColor,); // Default border color
          },
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            auth_icons.iconMap[userType] ?? const SizedBox(),
            if (userType != '해당 없음') // Check if userType is not '해당 없음'
              SizedBox(height: height * 0.06),
            Text(
              userType == '해당 없음' ? '해당 사항이 없어요' : userType,
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