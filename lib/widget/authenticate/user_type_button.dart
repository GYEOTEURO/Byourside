import 'package:flutter/material.dart';

class UserTypeButton extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onPressed;

  const UserTypeButton({
    required this.type,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
        foregroundColor: MaterialStateProperty.all(isSelected ? Colors.white : Colors.blue),
        side: MaterialStateProperty.all(BorderSide(color: isSelected ? Colors.white : Colors.blue)),
      ),
      child: Text(type),
    );
  }
}

class UserTypeSelection extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const UserTypeSelection({
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '어떤 유형의 사용자인지 알려주세요',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserTypeButton(
              type: '장애 아동 보호자',
              isSelected: selectedType == '장애 아동 보호자',
              onPressed: () => onTypeSelected('장애 아동 보호자'),
            ),
            UserTypeButton(
              type: '장애인',
              isSelected: selectedType == '장애인',
              onPressed: () => onTypeSelected('장애인'),
            ),
            UserTypeButton(
              type: '종사자',
              isSelected: selectedType == '종사자',
              onPressed: () => onTypeSelected('종사자'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        UserTypeButton(
          type: '해당 없음',
          isSelected: selectedType == '해당 없음',
          onPressed: () => onTypeSelected('해당 없음'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
