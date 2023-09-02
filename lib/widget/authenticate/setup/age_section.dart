import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeSection extends StatefulWidget {
  final TextEditingController controller;

  const AgeSection({Key? key, required this.controller}) : super(key: key);

  @override
  AgeSectionState createState() => AgeSectionState();
}

class AgeSectionState extends State<AgeSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO: 디자인 적용하고 const로 빼기
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
              child: buildAgeTextField(),
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

  Widget buildAgeTextField() {
    return Semantics(
      container: true,
      textField: true,
      label: '몇 년생인지 입력하세요.',
      hint: '(예: 1990)',
      child: TextFormField(
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: '1990',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // 숫자만 입력 가능
        ],
        keyboardType: TextInputType.number,
      ),
    );
  }
}
