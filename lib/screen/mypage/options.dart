import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

Widget myPageOptions(BuildContext context, String optionName, List<Map<String, dynamic>> options) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,
          child: Text(
          optionName,
          style: const TextStyle(
              color: colors.textColor,
              fontSize: 15,
              fontFamily: fonts.font,
              fontWeight: FontWeight.w700,
              height: 1.53,
            ),
          ), 
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height / 15 * options.length,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: colors.bgrColor),
                  borderRadius: BorderRadius.circular(10),
              ),
          ),
          child: Column(
            children: [
              for(int i = 0; i < options.length; i++)
              OutlinedButton(
                onPressed: () {
                  HapticFeedback.lightImpact(); // 약한 진동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => options[i]['page']));},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.height / 16),
                  elevation: 0,
                  side: const BorderSide(color: Colors.white),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    options[i]['name'],
                    style: const TextStyle(
                      color: colors.textColor,
                      fontSize: 15,
                      fontFamily: fonts.font,
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                    ),
                  )
              )),
              const Divider(color: colors.bgrColor, thickness: 1)
          ])
        )
    ]);
}

