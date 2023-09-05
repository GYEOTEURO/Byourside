import 'dart:io';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:image_picker/image_picker.dart';

Widget imageSection(
    double maxWidth, XFile image, TextEditingController imageInfo) {
  return SingleChildScrollView(
      child: Center(
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Semantics(
          label: '사용자가 선택한 사진 ',
          child: Container(
              width: maxWidth * 0.7,
              height: maxWidth * 0.7,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.08),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(File(image.path)),
                    // 보고 수정
                  )))),
      Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            '이미지 내용을 입력해주세요',
            semanticsLabel: '이미지 내용을 입력해주세요',
            style: TextStyle(
                color: colors.textColor,
                fontSize: fonts.semiBodyPt,
                fontWeight: FontWeight.bold,
                fontFamily: fonts.font),
          )),
      const Text(
        '스크린 리더를 위한 항목으로 게시글 작성 후 보이지는 않습니다',
        semanticsLabel: '스크린 리더를 위한 항목으로 게시글 작성 후 보이지는 않습니다',
        style: TextStyle(
            color: colors.subColor,
            fontSize: fonts.captionPt,
            fontWeight: FontWeight.normal,
            fontFamily: fonts.font),
      ),
      Semantics(
          label: '이미지 내용을 입력해주세요',
          child: Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                minLines: 1,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: fonts.font, fontWeight: FontWeight.normal),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(70.0)),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: colors.imgSubtitleColor,
                  hintText: '이미지 내용을 입력해주세요',
                  hintStyle: TextStyle(color: colors.textColor),
                ),
                controller: imageInfo,
              )))
    ],
  )));
}
