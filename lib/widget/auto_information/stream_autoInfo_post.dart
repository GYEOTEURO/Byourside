import 'package:byourside/model/autoInformation_post.dart';
import 'package:byourside/screen/autoInformation/autoInfo_post_list_tile.dart';
import 'package:byourside/widget/no_data.dart';
import 'package:flutter/material.dart';

Widget streamAutoInfoPost(Function loadData) {
  return StreamBuilder<List<AutoInformationPostModel>>(
      stream: loadData(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshots.data!.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                AutoInformationPostModel post = snapshots.data![index];
                return autoInfoPostListTile(context, post);
              });
        } else {
          return noData();
        }
      });
}
