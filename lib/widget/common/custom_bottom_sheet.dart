import 'package:byourside/widget/common/delete_report_block_alert.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:flutter/services.dart';


Future customBottomSheet(BuildContext context, bool isPostedUser, Function delete, Function report, Function block) {
  return showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.white,
                child: isPostedUser ?
                        bottomSheetButton(context, 1, constants.delete, () {delete();})
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          bottomSheetButton(context, 2.5, constants.report, (){report();}),
                          const Divider(thickness: 1, color: colors.subColor),
                          bottomSheetButton(context, 2.5, constants.block, () {block();})
                        ],
                        ), 
              );
            });
}

Widget bottomSheetButton(BuildContext context, double divideHeight, Map<String, String> optionType, Function pressed){
  return Container(
    height: MediaQuery.of(context).size.height / 4 / divideHeight,
    child: ElevatedButton(
    onPressed: () { 
      HapticFeedback.lightImpact();
      showDialog(
        context: context, 
        builder: (context) => DeleteReportBlockAlert(
      buttonText: optionType['alertButtonText']!, 
      message: optionType['message']!, 
      subMessage: optionType['subMessage']!, 
      onPressed: () { 
        pressed();
      }
    ));},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    child: Center(
      child: Text(
      optionType['bottomSheetText']!,
      semanticsLabel: optionType['bottomSheetText'],
      style: const TextStyle(
        color: colors.textColor,
        fontFamily: fonts.font,
      ),
    ),
  )
  ));
}

  