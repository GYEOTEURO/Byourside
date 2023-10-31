import 'package:byourside/constants/text.dart' as texts;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/icons.dart' as custom_icons;
import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/autoInformation/autoInfo_post_list_tile.dart';
import 'package:byourside/screen/autoInformation/post_list_appbar.dart';
import 'package:byourside/widget/common/category_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/load_data.dart';

class AutoInformationPostList extends StatefulWidget {
  const AutoInformationPostList({Key? key}) : super(key: key);

  @override
  State<AutoInformationPostList> createState() =>
      _AutoInformationPostListState();
}

class _AutoInformationPostListState extends State<AutoInformationPostList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  String selectedCategoryValue = texts.autoInformationCategories[0];
  String? selectedDisabilityTypeValue =
      Get.find<UserController>().userModel.disabilityType!.split(' ')[0] ==
              '해당없음'
          ? '발달'
          : Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  Map<String, String>? location = {
    'area': Get.find<UserController>().userModel.area!,
    'district': Get.find<UserController>().userModel.district!
  };

  void _handleCategorySelected(String value) {
    if (value == '돌봄서비스') {
      value = '돌봄 서비스';
    } else if (value == '교육/활동') {
      value = '교육';
    }
    setState(() {
      selectedCategoryValue = value;
    });
  }

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
    return Scaffold(
      body: Column(children: [
        AutoInformationPostListAppBar(
            onLocationSelected: _handleLocationSelected,
            onDisabilityTypeSelected: _handleDisabilityTypeSelected),
        Container(
            width: MediaQuery.of(context).size.width,
            color: colors.appBarColor,
            padding: const EdgeInsets.fromLTRB(20, 0, 14, 20),
            child: CategoryButtons(
                category: texts.autoInformationCategories,
                onCategorySelected: _handleCategorySelected)),
        Expanded(
            child: StreamBuilder<List<AutoInformationPostModel>>(
                stream: loadData.readAutoInformationPosts(
                    category: selectedCategoryValue,
                    area: location!['area'],
                    district: location!['district'],
                    disabilityType: selectedDisabilityTypeValue),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                        itemCount: snapshots.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          AutoInformationPostModel post = snapshots.data![index];
                          return autoInfoPostListTile(context, post);
                        });
                  } else {
                    return SelectionArea(
                        child: Center(child: custom_icons.loading));
                  }
                }))
      ]),
    );
  }
}
