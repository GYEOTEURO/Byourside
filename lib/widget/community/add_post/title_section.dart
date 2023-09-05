import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:flutter/services.dart';

class TitleSection extends StatefulWidget {
  const TitleSection(
      {super.key, required this.titleController, required this.focus});

  final TextEditingController titleController;
  final FocusNode focus;

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
        label: '제목을 입력하세요',
        child: TextFormField(
          style: const TextStyle(
              fontFamily: fonts.font, fontWeight: FontWeight.normal),
          autofocus: true,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '제목은 비어있을 수 없습니다';
            }
            return null;
          },
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(widget.focus),
          decoration: const InputDecoration(
              labelText: '제목',
              hintText: '제목을 입력하세요',
              labelStyle: TextStyle(
                  color: colors.subColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fonts.semiTitlePt),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: colors.subColor),
              )),
          controller: widget.titleController,
        ));
  }
}
