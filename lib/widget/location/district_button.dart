import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;

class DistrictButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final double deviceWidth;
  final double deviceHeight;

  const DistrictButton({
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
      width: getRelativeWidth(0.25),
      height: getRelativeHeight(0.045), // You may adjust the height as needed
      margin: EdgeInsets.symmetric(vertical: getRelativeHeight(0.007)), // Add horizontal padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
            fontWeight: FontWeight.w400,
            color: Colors.black, // Change text color based on selection
          ),
        ),
      ),
    );
  }
}
