import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/widget/common/icon_buttons.dart';
import 'package:byourside/widget/common/change_disability_type.dart';
import 'package:byourside/widget/common/app_bar_select_button.dart';
import 'package:byourside/widget/location/location_dialog.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/text.dart' as texts;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AutoInformationPostListAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  AutoInformationPostListAppBar(
      {Key? key,
      required this.onLocationSelected,
      required this.onDisabilityTypeSelected})
      : super(key: key);

  final Function(String area, String district) onLocationSelected;
  final ValueChanged<String> onDisabilityTypeSelected;

  @override
  State<AutoInformationPostListAppBar> createState() =>
      _AutoInformationPostListAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _AutoInformationPostListAppBarState
    extends State<AutoInformationPostListAppBar> {
  String? selectedDisabilityTypeValue =
      Get.find<UserController>().userModel.disabilityType!.split(' ')[0] ==
              '해당없음'
          ? '발달'
          : Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  Map<String, String>? location = {
    'area': Get.find<UserController>().userModel.area!,
    'district': Get.find<UserController>().userModel.district!
  };

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  void _handleLocationSelected(String selectedArea, String selectedDistrict) {
    setState(() {
      location = {
        'area': selectedArea,
        'district': selectedDistrict,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.appBarColor,
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                GestureDetector(
                  child: appBarSelectButton(context, location!['district']!),
                  onTap: () {
                      HapticFeedback.lightImpact();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LocationDialog(onLocationSelected: _handleLocationSelected, onLocationSelectedFromPostList: widget.onLocationSelected, deviceHeight: MediaQuery.of(context).size.height, deviceWidth: MediaQuery.of(context).size.width, title: '',);
                      });
                }),
                const SizedBox(width: 6),
                GestureDetector(
                  child: appBarSelectButton(context, selectedDisabilityTypeValue!),
                  onTap: () {
                      HapticFeedback.lightImpact();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ChangeDisabilityType(onDisabilityTypeSelectedFromAppBar: _handleDisabilityTypeSelected, onDisabilityTypeSelectedFromPostList: widget.onDisabilityTypeSelected);
                      });
                })
              ]),
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
                    texts.autoInformationTitle,
                    semanticsLabel: texts.autoInformationTitle,
                    style: TextStyle(
                        color: colors.textColor,
                        fontFamily: fonts.font,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ));
  }
}
