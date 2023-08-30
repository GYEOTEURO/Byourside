import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/user_block_list_controller.dart';
import 'package:byourside/widget/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyBlock extends StatefulWidget {
  const MyBlock({Key? key}) : super(key: key);
  final String title = '차단 목록';

  @override
  State<MyBlock> createState() => _MyBlockState();
}

class _MyBlockState extends State<MyBlock> {
  final userBlockListController = Get.put(UserBlockListController());

  Widget _buildListItem() {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: userBlockListController.blockedUser.isEmpty == true ?
                const Center(
                    child: Text('없음',
                        semanticsLabel: '차단한 사용자 없음',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: fonts.font,
                          fontWeight: FontWeight.w600,
                        )))
              : Column(
                    children: userBlockListController.blockedUser.map((e) => 
                            Column(
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e,
                                      semanticsLabel: e,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: fonts.font,
                                        fontWeight: FontWeight.w600,
                                      )),
                                      OutlinedButton(
                                        onPressed: () {
                                          HapticFeedback.lightImpact(); // 약한 진동
                                          userBlockListController.removeBlockedUser(e);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(93),
                                          side: const BorderSide(
                                            width: 0.50,
                                            color: colors.subColor,
                                          ),
                                          )),
                                          child: const Text(
                                            '차단 해제',
                                            semanticsLabel: '차단 해제',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: colors.subColor,
                                              fontSize: 13,
                                              fontFamily: fonts.font,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                ]),
                                const Divider(color: colors.bgrColor, thickness: 1)
                                ]),
                              )
                        .toList())
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleOnlyAppbar(context, widget.title),
      body: _buildListItem()
    );}

}

