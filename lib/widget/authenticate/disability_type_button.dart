import 'package:flutter/material.dart';


class TypeButtonWidget extends StatelessWidget {
  final List<Widget> type;
  final int selectedIndex;
  final Function(int) onButtonPressed;

  const TypeButtonWidget({super.key, required this.type, required this.selectedIndex, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: type.asMap().entries.map((entry) {
          var index = entry.key;
          var widget = entry.value;
          var isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                onButtonPressed(index);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
                foregroundColor: MaterialStateProperty.all(isSelected ? Colors.white : Colors.blue),
                side: MaterialStateProperty.all(BorderSide(color: isSelected ? Colors.white : Colors.blue)),
              ),
              child: widget,
            ),
          );
        }).toList(),
      ),
    );
  }
}