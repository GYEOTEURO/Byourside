import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeDisabilityType extends StatefulWidget {
  ChangeDisabilityType(
      {super.key,
      required this.onDisabilityTypeSelectedFromPostList,
      required this.onDisabilityTypeSelectedFromAppBar});

  final ValueChanged<String> onDisabilityTypeSelectedFromPostList;
  final ValueChanged<String> onDisabilityTypeSelectedFromAppBar;    

  @override
  State<ChangeDisabilityType> createState() => _ChangeDisabilityTypeState();
}

class _ChangeDisabilityTypeState extends State<ChangeDisabilityType> {

  String selectedType = '';

  @override
  void initState() {
    super.initState();
    selectedType = '발달';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                  ),
                  semanticLabel:
                      '장애 유형을 선택해주세요',
                  title: const Text(
                      '장애 유형을 선택해주세요',
                      semanticsLabel: '장애 유형을 선택해주세요',
                      style: TextStyle(
                          color: colors.textColor,
                          fontSize: 13,
                          fontFamily: fonts.font,
                          fontWeight: FontWeight.w400,
                          height: 1.69,
                      ),
                  ),
                  actions: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(69),
                                ),
                              ),
                              child: const Text('발달장애',
                                  semanticsLabel: '발달장애',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fonts.font,
                                    color: colors.textColor,
                                    fontWeight: FontWeight.w600,
                              )),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                selectedType = '발달';
                                widget.onDisabilityTypeSelectedFromPostList(selectedType);
                                widget.onDisabilityTypeSelectedFromAppBar(selectedType);
                                Navigator.pop(context);
                              },
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(69),
                                ),
                              ),
                              child: const Text('뇌병변장애',
                                  semanticsLabel: '뇌병변장애',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fonts.font,
                                    color: colors.textColor,
                                    fontWeight: FontWeight.w600,
                              )),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                selectedType = '뇌병변';
                                widget.onDisabilityTypeSelectedFromPostList(selectedType);
                                widget.onDisabilityTypeSelectedFromAppBar(selectedType);
                                Navigator.pop(context);
                              },
                          )
                        ])
                  ]);
            }
}