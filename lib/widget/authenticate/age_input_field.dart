import 'package:flutter/material.dart';

class AgeInputField extends StatefulWidget {
  final TextEditingController controller;

  const AgeInputField({Key? key, required this.controller}) : super(key: key);

  @override
  _AgeInputFieldState createState() => _AgeInputFieldState();
}

class _AgeInputFieldState extends State<AgeInputField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '나이를 입력해 주세요',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            Flexible(
              child: Semantics(
                container: true,
                textField: true,
                label: '몇 년생인지 입력하세요.',
                hint: '(예: 1990)',
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: '1990',
                    errorText: _errorText,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _errorText = validateBirthYear(value);
                    });
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('년생'),
            ),
          ],
        ),
      ],
    );
  }

  String? validateBirthYear(String value) {
    if (value.isEmpty) {
      return '나이를 입력하세요.';
    }
    if (!isNumeric(value)) {
      return '숫자만 입력하세요.';
    }
    // 필요한 추가 유효성 검사를 여기에 추가할 수 있습니다.
    return null; // 유효성 검사를 통과하면 null 반환
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
