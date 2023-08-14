import 'package:flutter/material.dart';

Widget buildDisabilityTypeButtons(int selectedIndex, Function(int) onButtonPressed) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTypeButton('뇌병변 장애', selectedIndex == 0, () => onButtonPressed(0)),
        buildTypeButton('발달 장애', selectedIndex == 1, () => onButtonPressed(1)),
        buildTypeButton('해당없음', selectedIndex == 2, () => onButtonPressed(2)),
      ],
    ),
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