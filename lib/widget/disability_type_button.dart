import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

Widget disabilityTypeButton(BuildContext context, String selectedDisabilityTypeValue) {
return Container(
          width: MediaQuery.of(context).size.width / 5.5,
          height: MediaQuery.of(context).size.height / 36,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: const ShapeDecoration(
              color: colors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13),
                  ),
              ),
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text(
                      selectedDisabilityTypeValue,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: fonts.captionPt,
                        fontFamily: fonts.font,
                        fontWeight: FontWeight.w400,
                      ),
                  ),
                ],
            ),
          );
      }