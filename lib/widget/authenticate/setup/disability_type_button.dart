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

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }


  Widget buildDisabilityTypeChip(String type, double deviceWidth, double deviceHeight) {
    bool isSelected = _selectedType == type;

    return SizedBox(
      width: deviceWidth * 0.3, 
      height: deviceHeight * 0.05, 
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
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;


    return Padding(
      padding: EdgeInsets.all(deviceWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplainText(
            text: '장애 유형을 선택해 주세요',
            width: deviceWidth * 0.04,
          ),
          SizedBox(height: deviceHeight * 0.02), 
          Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              buildDisabilityTypeChip('발달 장애', deviceWidth, deviceHeight),
              buildDisabilityTypeChip('뇌병변 장애', deviceWidth, deviceHeight),
              buildDisabilityTypeChip('해당없음', deviceWidth, deviceHeight),
            ],
          ),
        ],
      ),
    );
  }

}
