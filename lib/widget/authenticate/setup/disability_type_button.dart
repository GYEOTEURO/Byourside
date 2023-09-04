import 'package:byourside/widget/authenticate/setup/explain_text.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';

class DisabilityType extends StatefulWidget {
  final String initialType;
  final Function(String) onChanged;

  const DisabilityType({
    Key? key,
    required this.initialType,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DisabilityTypeState createState() => _DisabilityTypeState();
}

class _DisabilityTypeState extends State<DisabilityType> {
  late String _selectedType;
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
    _selectedType = widget.initialType;
  }


  double getRelativeWidth(double value) {
    return _deviceWidth * value;
  }

  double getRelativeHeight(double value) {
    return _deviceHeight * value;
  }


  Widget buildDisabilityTypeChip(String type, double deviceWidth, double deviceHeight) {
    bool isSelected = _selectedType == type;

    return SizedBox(
      width: getRelativeWidth(0.3), 
      height: getRelativeHeight(0.05), 
      child: ChoiceChip(
        label: Text(
          type,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center, 
        ),
        selected: isSelected,
        onSelected: (isSelected) {
          if (isSelected) {
            setState(() {
              _selectedType = type;
              widget.onChanged(type);
            });
          }
        },
        selectedColor: colors.primaryColor,
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: colors.primaryColor, 
          width: 1.0, 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(getRelativeWidth(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplainText(
            text: '장애 유형을 선택해 주세요',
            width: getRelativeWidth(0.04),
          ),
          SizedBox(height: getRelativeHeight(0.02)), 
          Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              buildDisabilityTypeChip('발달 장애', getRelativeWidth(1), getRelativeHeight(1)),
              buildDisabilityTypeChip('뇌병변 장애', getRelativeWidth(1), getRelativeHeight(1)),
              buildDisabilityTypeChip('해당없음', getRelativeWidth(1), getRelativeHeight(1)),
            ],
          ),
        ],
      ),
    );
  }

}
