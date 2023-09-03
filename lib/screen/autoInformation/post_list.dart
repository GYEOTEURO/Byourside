import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/icons.dart' as customIcons;
import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/authenticate/controller/user_controller.dart';
import 'package:byourside/screen/autoInformation/post_list_appbar.dart';
import 'package:byourside/widget/category_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/load_data.dart';

class AutoInformationPostList extends StatefulWidget {
  const AutoInformationPostList(
      {Key? key})
      : super(key: key);

  @override
  State<AutoInformationPostList> createState() => _AutoInformationPostListState();
}

class _AutoInformationPostListState extends State<AutoInformationPostList> {
  final User? user = FirebaseAuth.instance.currentUser;
  final LoadData loadData = LoadData();
  String selectedChipValue = constants.autoInformationCategories[0];
  String? selectedDisabilityTypeValue = Get.find<UserController>().userModel.disabilityType!.split(' ')[0] == '해당없음' ? '발달' : Get.find<UserController>().userModel.disabilityType!.split(' ')[0];
  String? selectedLocationValue = Get.find<UserController>().userModel.district;

  void _handleChipSelected(String value) {
    if(value == '돌봄서비스') {
      value = '돌봄 서비스';
    } else if(value == '교육/활동') {
      value = '교육';
    }
    setState(() {
      selectedChipValue = value;
    });
  }

  void _handleDisabilityTypeSelected(String value) {
    setState(() {
      selectedDisabilityTypeValue = value;
    });
  }

  void _handleLocationSelected(String value) {
    setState(() {
      selectedLocationValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AutoInformationPostListAppBar(onLocationSelected: _handleLocationSelected, onDisabilityTypeSelected: _handleDisabilityTypeSelected),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CategoryButtons(category: constants.autoInformationCategories, onChipSelected: _handleChipSelected)
          ),
          Expanded(
            child: StreamBuilder<List<AutoInformationPostModel>>(
              stream: loadData.readAutoInformationPosts(category: selectedChipValue, disabilityType: selectedDisabilityTypeValue),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return ListView.builder(
                      itemCount: snapshots.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        AutoInformationPostModel post = snapshots.data![index];
                        //return communityPostListTile(context, post);
                      });
              } else {
                return SelectionArea(
                  child: Center(
                    child: customIcons.loading
                  )
                );
              }
            })
          )
          ]),
     );
  }
}
