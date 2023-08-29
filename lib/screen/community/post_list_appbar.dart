import 'package:byourside/screen/mypage/my_scrap.dart';
import 'package:byourside/widget/change_disability_type.dart';
import 'package:byourside/widget/fully_rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/constants/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  String selectedDisabilityTypeValue = '발달';

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: colors.appBarColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(5,5),
            child: 
              Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
          )),
          leading: Container(
            //height: 22,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                showDialog(
                    context: context,
                    builder: (context) {
                      return ChangeDisabilityType(onDisabilityTypeSelectedFromAppBar: _handleDisabilityTypeSelected, onDisabilityTypeSelectedFromPostList: widget.onDisabilityTypeSelected);
              });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                  ),
                ),
              ),
              child: Text(
                selectedDisabilityTypeValue,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: fonts.captionPt,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ),
          actions: [
            IconButton(
              icon: customIcons.gotoScrapPage, 
              onPressed: (){
                HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyScrap()));
              }),
            IconButton(
              icon: customIcons.search, 
              onPressed: (){
                HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyScrap()));
              }),
          ],
    );
  }
}
