import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;

class AreaButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final double deviceWidth;
  final double deviceHeight;

  const AreaButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  double getRelativeWidth(double value) {
    return deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return deviceHeight * value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getRelativeWidth(0.28),
      height: getRelativeHeight(0.055),
      margin: EdgeInsets.symmetric(vertical: getRelativeHeight(0.007)),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: isSelected ? colors.primaryColor : Colors.white,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: getRelativeWidth(0.04),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
