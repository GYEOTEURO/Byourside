import 'package:byourside/model/notice.dart';
import 'package:byourside/widget/common/time_convertor.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

class NoticeDetailPage extends StatelessWidget {
  final NoticeModel notice;
  
  const NoticeDetailPage({
    Key? key,
    required this.notice
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
      TimeConvertor createdAt = TimeConvertor(createdAt: notice.createdAt, fontSize: 13.0);
     
    return Scaffold(
        appBar: titleOnlyAppbar(context, '공지사항'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  notice.title,
                  semanticsLabel: notice.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w700,
                ))
              ),
              const SizedBox(height: 15),
              Align(alignment: Alignment.centerLeft, child: createdAt),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                decoration: BoxDecoration(
                    color: colors.autoInfoContentBgrColor,
                    borderRadius: BorderRadius.circular(9)),
                child: Text(
                  notice.content,
                  semanticsLabel: notice.content,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: fonts.font,
                    fontWeight: FontWeight.w700,
                    height: 1.5
                )),
              )
          ])
      )
    );
  }
}
