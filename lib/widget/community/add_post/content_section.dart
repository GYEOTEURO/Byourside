import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

class ContentSection extends StatefulWidget {
  const ContentSection(
      {super.key, required this.contentController, required this.focus});

  final TextEditingController contentController;
  final FocusNode focus;

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Semantics(
            label: '내용을 입력해주세요',
            child: TextField(
              style: const TextStyle(
                  fontFamily: fonts.font, fontWeight: FontWeight.normal),
              focusNode: widget.focus,
              controller: widget.contentController,
              minLines: 20,
              maxLines: 20,
              decoration: const InputDecoration(
                  hintText: '내용을 입력해주세요',
                  hintStyle: TextStyle(
                      color: colors.subColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fonts.bodyPt),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: colors.subColor),
                  )),
            )));
  }
}
