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
      height: getRelativeHeight(0.055), // You may adjust the height as needed
      margin: EdgeInsets.symmetric(vertical: getRelativeHeight(0.007)), // Add horizontal padding
      decoration: BoxDecoration(
        borderRadius: isSelected
            ? const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.circular(20), // Apply circular border to the entire button
        color: isSelected ? colors.primaryColor : Colors.white,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make the button background transparent
          shadowColor: Colors.transparent, // Remove button shadow
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: getRelativeWidth(0.04),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black, // Change text color based on selection
          ),
        ),
      ),
    );
  }
}
