import 'package:flutter/material.dart';

class AppPurposeSelection extends StatefulWidget {
  const AppPurposeSelection({super.key, required Null Function(dynamic purpose) onChanged});

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
            setState(() {
              _selectedPurpose = newValue!;
            });
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
