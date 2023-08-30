import 'package:byourside/model/community_post.dart';
import 'package:byourside/screen/community/community_post_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/fonts.dart' as fonts;

Widget streamCommunityPost(Function loadData, List<String> blockedUser) {
    return StreamBuilder<List<CommunityPostModel>>(
            stream: loadData(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshots.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      CommunityPostModel post = snapshots.data![index];
                      if (blockedUser.contains(post.uid)) {
                        return Container();
                      } else {
                        return communityPostListTile(context, post);
                      }
                    })
              );
              } else {
                return const SelectionArea(
                    child: Center(
                        child: Text(
                          '없음',
                          semanticsLabel: '없음',
                          style: TextStyle(
                            fontFamily: fonts.font,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                ));
              }
            });
}