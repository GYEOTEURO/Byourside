import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:byourside/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;

Widget streamCommunityPost(Function loadData) {
    return StreamBuilder<List<CommunityPostModel>>(
            stream: loadData(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                    itemCount: snapshots.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      CommunityPostModel post = snapshots.data![index];
                      return communityPostListTile(context, post);
                    });
              } else {
                return noData();
              }
            });
}