import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildUserTypeButtons(int selectedIndex, Function(int) onButtonPressed) {
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
          buildTypeButton('장애 아동 보호자', selectedIndex == 0, () => onButtonPressed(0)),
          buildTypeButton('장애인', selectedIndex == 1, () => onButtonPressed(1)),
          buildTypeButton('종사자', selectedIndex == 2, () => onButtonPressed(2)),
        ],
      ),
      const SizedBox(height: 20),
      buildTypeButton('해당 없음', selectedIndex == 3, () => onButtonPressed(3)),
      const SizedBox(height: 20),
    ],
  );
}



Widget buildTypeButton(String text, bool isSelected, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
      foregroundColor: MaterialStateProperty.all(isSelected ? Colors.white : Colors.blue),
      side: MaterialStateProperty.all(BorderSide(color: isSelected ? Colors.white : Colors.blue)),
    ),
    child: Text(text),
  );
}
