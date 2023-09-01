// import 'package:byourside/model/community_post.dart';
// import 'package:byourside/model/load_data.dart';
// import 'package:byourside/screen/community/community_post_list_tile.dart';
// import 'package:byourside/screen/community/post.dart';
// import 'package:byourside/widget/back_to_previous_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:byourside/constants/fonts.dart' as fonts;
// import 'package:byourside/constants/colors.dart' as colors;
// class CommunitySearch extends StatefulWidget {
//   const CommunitySearch({Key? key}) : super(key: key);

//   @override
//   State<CommunitySearch> createState() => _CommunitySearchState();
// }

// class _CommunitySearchState extends State<CommunitySearch> {
//   final TextEditingController query = TextEditingController();
//   final User? user = FirebaseAuth.instance.currentUser;
//   final LoadData loadData = LoadData();

//   @override
//   Widget build(BuildContext context) {
//     List<String> blockList;

//     return Scaffold(
//         body: Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                   backToPreviousPage(context),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Semantics(
//                       container: true,
//                       textField: true,
//                       label: '소통 게시판 내 검색',
//                       child: TextFormField(
//                         onTap: () { HapticFeedback.lightImpact(); },
//                         controller: query,
//                         maxLines: 1,
//                         decoration: InputDecoration(
//                           labelText: '소통 게시판 내 검색',
//                           fillColor: colors.bgrColor,
//                           filled: true,
//                           labelStyle: const TextStyle(
//                               color: colors.textColor,
//                               fontSize: 10,
//                               fontFamily: fonts.font,
//                               fontWeight: FontWeight.w500),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(28),
//                               borderSide: BorderSide.none),
//                           )
//                         )
//                       )),
//                   ]),
//                   StreamBuilder<List<CommunityPostModel>>(
//                           stream: loadData.searchCommunityPosts(query.text),
//                           builder: (context, snapshots) {
//                             if (snapshots.hasData) {
//                               return ListView.builder(
//                                   itemCount: snapshots.data!.length,
//                                   itemBuilder: (_, index) {
//                                     CommunityPostModel post = snapshots.data![index];
//                                     if (blockList.contains(post.nickname)) {
//                                       return Container();
//                                     } else {
//                                       return communityPostListTile(context, post);
//                                     }
//                                   });
//                             } else {
//                               return Container();
//                             }
//                   })
//               ])
//         ));
//   }
// }
