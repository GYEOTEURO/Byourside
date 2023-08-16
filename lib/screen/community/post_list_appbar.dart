import 'package:byourside/constants/icons.dart';
import 'package:byourside/screen/community/community_categories.dart';
import 'package:byourside/screen/community/controller/disability_type_controller.dart';
import 'package:byourside/screen/community/search_page.dart';
import 'package:byourside/screen/mypage/my_scrap_community_post.dart';
import 'package:byourside/widget/change_disability_type.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityPostListAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommunityPostListAppBar(
    {Key? key}) 
    : super(key: key);

  final String title = '소통 게시판';

  @override
  State<CommunityPostListAppBar> createState() => _CommunityPostListAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _CommunityPostListAppBarState extends State<CommunityPostListAppBar> {
  @override
  Widget build(BuildContext context) {

    final communityDisabilityTypeController = Get.put(CommunityDisabilityTypeController());
    
    return AppBar(
          backgroundColor: colors.communityAppBar,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(5,5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                semanticsLabel: widget.title,
                style: const TextStyle(
                    color: colors.textColor, 
                    fontFamily: fonts.font, 
                    fontSize: 20, 
                    fontWeight: FontWeight.w700
                ),
          ))),
          //leadingWidth: 70,
          leading: IntrinsicWidth(
            child: Container(
            constraints: BoxConstraints(
              maxHeight: 22,
              maxWidth: 70,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                showDialog(
                    context: context,
                    builder: (context) {
                      return ChangeDisabilityType();
              });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                  ),
                ),
              ),
              child: Text(
                communityDisabilityTypeController.disabilityType,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fonts.captionPt,
                  fontFamily: fonts.font,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          )),
          actions: [
            IconButton(
              icon: customIcons.gotoScrapPage, 
              onPressed: (){
                HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyScrapCommunityPost()));
              }),
            IconButton(
              icon: customIcons.search, 
              onPressed: (){
                HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyScrapCommunityPost()));
              }),
          ],
    );
  }
}
