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
        buildHeaderText(),
        SizedBox(height: 10),
        buildDropdownButton(),
      ],
    );
  }

  Widget buildHeaderText() {
    return const Text(
      '어플 사용 목적을 알려주세요',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget buildDropdownButton() {
    return DropdownButton<String>(
      value: _selectedPurpose,
      onChanged: handlePurposeChanged,
      items: ['정보 습득', '활동 홍보', '소통']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void handlePurposeChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedPurpose = newValue;
        widget.onChanged(newValue);
      });
    }
  }
}
