import 'package:flutter/material.dart';

class AppPurposeSelection extends StatefulWidget {
  final void Function(String purpose) onChanged;

  const AppPurposeSelection({Key? key, required this.onChanged}) : super(key: key);

  @override
  _AppPurposeSelectionState createState() => _AppPurposeSelectionState();
}

class _AppPurposeSelectionState extends State<AppPurposeSelection> {
  String _selectedPurpose = '정보 습득';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '어플 사용 목적을 알려주세요',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: _selectedPurpose,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                print(newValue);
                _selectedPurpose = newValue;
                widget.onChanged(newValue); // onChanged 콜백 호출
              });
            }
          },
          items: <String>['정보 습득', '활동 홍보', '소통']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
