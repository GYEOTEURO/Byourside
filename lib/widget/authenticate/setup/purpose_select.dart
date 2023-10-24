import 'package:flutter/material.dart';
import 'package:byourside/constants/text.dart' as text;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/widget/authenticate/setup/explain_text.dart';


class AppPurposeSelection extends StatefulWidget {
  final void Function(String purpose) onChanged;

  const AppPurposeSelection({Key? key, required this.onChanged}) : super(key: key);

  @override
  AppPurposeSelectionState createState() => AppPurposeSelectionState();
}

class AppPurposeSelectionState extends State<AppPurposeSelection> {
  String _selectedPurpose = text.getInformation;
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


  Widget buildHeaderText() {
    return ExplainText(
      text : text.askPurpose,
      width : getRelativeWidth(0.04),
    );
  }
  
  Widget buildDropdownButton() {
    return SizedBox(
      width: getRelativeWidth(0.89),
      height: getRelativeHeight(0.08),
      child: DropdownButtonFormField<String>(
          value: _selectedPurpose,
          onChanged: handlePurposeChanged,
          items: [text.getInformation, text.promotion, text.communication]
            .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.06)), // 원하는 패딩 값을 지정합니다.
              child: Text(
                value,
                style: TextStyle(
                  fontSize: getRelativeHeight(0.02),
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
                ),
              );
            }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: colors.primaryColor,
                width: getRelativeWidth(0.003), 
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: colors.primaryColor, 
                width: getRelativeWidth(0.003),
              ),
            ),
          ),
          isExpanded: true,
          focusColor: colors.bgrColor,
        ),
      );
    }

  void handlePurposeChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedPurpose = newValue;
        widget.onChanged(newValue);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderText(),
          SizedBox(height: getRelativeHeight(0.02)),
          buildDropdownButton(),
        ],
      ),
    );
  }

}
