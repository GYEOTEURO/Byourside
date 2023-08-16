import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/screen/community/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class communityCategoryButtons extends StatefulWidget {
  const communityCategoryButtons(
      {super.key});

  @override
  State<communityCategoryButtons> createState() => _communityCategoryButtonsState();
}

class _communityCategoryButtonsState extends State<communityCategoryButtons> {

  @override
  Widget build(BuildContext context) {
    final communityCategoryController = Get.put(CommunityCategoryController());
  
    return Container(
      color: colors.communityAppBar,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i=0; i<constants.communityCategories.length; i++) 
          Row(
            children: [
              GestureDetector(
                onTap: () { 
                  communityCategoryController.changeCategory(constants.communityCategories[i]); 
                  //communityCategoryController.update();  
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  clipBehavior: Clip.antiAlias,
                  decoration: communityCategoryController.category == constants.communityCategories[i] ? 
                  ShapeDecoration(
                    color: colors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))
                  : ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.50, color: colors.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                      constants.communityCategories[i],
                      style: const TextStyle(
                      color: colors.textColor,
                      fontSize: fonts.bodyPt,
                      fontFamily: fonts.font,
                      height: 1,
                      ),
                  ),
                )
              ),
            const SizedBox(width: 9),    
          ],)
      ])
    );
}
}