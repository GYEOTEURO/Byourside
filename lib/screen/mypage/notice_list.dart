
import 'package:byourside/model/load_data.dart';
import 'package:byourside/model/notice.dart';
import 'package:byourside/screen/mypage/notice_detail.dart';
import 'package:byourside/widget/common/no_data.dart';
import 'package:byourside/widget/common/time_convertor.dart';
import 'package:byourside/widget/common/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;

class NoticeListPage extends StatelessWidget {
  NoticeListPage({Key? key}) : super(key: key);

  final LoadData loadData = LoadData();

  Widget _noticeListTile(context, NoticeModel notice) {
    TimeConvertor createdAt = TimeConvertor(createdAt: notice.createdAt, fontSize: 10.0);
     
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoticeDetailPage(notice: notice)));
      },
      child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                notice.title,
                semanticsLabel: notice.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w700,
                )),
            ),
            createdAt,
          ]),
          const SizedBox(height: 10),
          const Divider(color: colors.bgrColor, thickness: 1),
          const SizedBox(height: 10),
      ])
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: titleOnlyAppbar(context, '공지사항'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: StreamBuilder<List<NoticeModel>>(
            stream: loadData.readNotice(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                  itemCount: snapshots.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    NoticeModel notice = snapshots.data![index];
                    return _noticeListTile(context, notice);
                  });
              } else {
                return noData();
            }
        })
      )
    );
  }
}