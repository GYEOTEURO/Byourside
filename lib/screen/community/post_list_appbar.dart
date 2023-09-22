import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:byourside/widget/common/change_disability_type.dart';
import 'package:byourside/widget/common/app_bar_select_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityPostListAppBar extends StatefulWidget implements PreferredSizeWidget {
  CommunityPostListAppBar(
    {Key? key,
    required this.onDisabilityTypeSelected}) 
    : super(key: key);

  final ValueChanged<String> onDisabilityTypeSelected;

  @override
  State<CommunityPostListAppBar> createState() => _CommunityPostListAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _CommunityPostListAppBarState extends State<CommunityPostListAppBar> {
  String? selectedDisabilityTypeValue = 
    Get.find<UserController>().userModel.disabilityType!.split(' ')[0] == '해당없음' ? 
    '발달' 
    : Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  
  void _handleDisabilityTypeSelected(String value) {
  setState(() {
    selectedDisabilityTypeValue = value;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.lightPrimaryColor,
      padding: const EdgeInsets.fromLTRB(20, 33, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: appBarSelectButton(context, selectedDisabilityTypeValue!),
                onTap: () {
                    HapticFeedback.lightImpact();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ChangeDisabilityType(onDisabilityTypeSelectedFromAppBar: _handleDisabilityTypeSelected, onDisabilityTypeSelectedFromPostList: widget.onDisabilityTypeSelected);
                    });
              }),
              Row(
                children: [
                  goToScrapPage(context),
                  goToSearchPage(context)
                ])
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: const Text(
                constants.communityTitle,
                semanticsLabel: constants.communityTitle,
                style: TextStyle(
                    color: colors.textColor, 
                    fontFamily: fonts.font, 
                    fontSize: 20, 
                    fontWeight: FontWeight.w700
                ),
            )),
          )
        ],
      )
    );
  }
}
