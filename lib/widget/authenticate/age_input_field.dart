import 'package:flutter/material.dart';

class AgeInputField extends StatelessWidget {
  final TextEditingController controller;

  const AgeInputField({Key? key, required this.controller}) : super(key: key);

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
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: '1990',
                  ),
                  keyboardType: TextInputType.number,
                  // ... 텍스트필드 관련 설정 및 검증 로직 ...
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
}
