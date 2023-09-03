import 'package:byourside/widget/authenticate/setup/explain_text.dart';
import 'package:flutter/material.dart';

class DisabilityType extends StatefulWidget {
  final String initialType;
  final Function(String) onChanged;

  const DisabilityType({Key? key, required this.initialType, required this.onChanged})
      : super(key: key);

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
            text: '장애 유형을 선택해주세요',
            width: deviceWidth * 0.04,
          ),
          SizedBox(height: deviceHeight * 0.02), // 텍스트와 버튼 간격
          Row(
            children: [
              buildDisabilityTypeChip('뇌병변 장애'),
              buildDisabilityTypeChip('발달 장애'),
              buildDisabilityTypeChip('해당없음'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDisabilityTypeChip(String type) {
    return ChoiceChip(
      label: Text(type),
      selected: _selectedType == type,
      onSelected: (isSelected) {
        if (isSelected) {
          setState(() {
            _selectedType = type;
            widget.onChanged(type); // 선택된 장애 유형을 콜백으로 전달
          });
        }
      },
      selectedColor: Colors.blue,
      backgroundColor: Colors.grey,
    );
  }
}
