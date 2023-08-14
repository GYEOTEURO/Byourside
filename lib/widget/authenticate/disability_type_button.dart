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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '장애 종류를 선택해주세요',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 8), // 텍스트와 버튼 간격
      Row(
        children: [
          buildDisabilityTypeChip('뇌병변 장애'),
          buildDisabilityTypeChip('발달 장애'),
          buildDisabilityTypeChip('해당없음'),
        ],
      ),
    ],
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
            widget.onChanged(type); // 외부로 선택된 타입을 전달
          });
        }
      },
      selectedColor: Colors.blue,
      backgroundColor: Colors.grey,
    );
  }
}
