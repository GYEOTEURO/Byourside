import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;

class CompleteButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  
  const CompleteButton({super.key, required this.onPressed, required this.text});
  
  @override
  CompleteButtonState createState() => CompleteButtonState();

}

class CompleteButtonState extends State<CompleteButton> {

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
    return Container(
      margin: EdgeInsets.all(getRelativeWidth(0.04)),
      width: getRelativeWidth(0.8),
      height: getRelativeHeight(0.08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), 
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(colors.primaryColor),
        ),
        child: Text(
          widget.text,
          semanticsLabel: widget.text,
          style: TextStyle(
            fontSize: getRelativeHeight(0.025), // Adjust the font size as needed
            fontWeight: FontWeight.w700, // Set font weight to FontWeight.w700
            color: Colors.black, // Set text color to black
          ),
        ),
      ),
    );
  }
}