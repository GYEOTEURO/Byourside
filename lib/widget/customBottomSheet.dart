import 'package:byourside/widget/delete_report_block_alert.dart';
import 'package:flutter/material.dart';
import 'package:byourside/constants/constants.dart' as constants;
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;


Future customBottomSheet(BuildContext context, bool isPostedUser, Function delete, Function report, Function block) {
  return showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height /4,
                color: Colors.white,
                child: isPostedUser ?
                        bottomSheetButton(context, 4, constants.delete, () {delete();})
                      : Column(
                        children: <Widget>[
                          bottomSheetButton(context, 16, constants.report, (){report();}),
                          const Divider(thickness: 1, color: colors.subColor),
                          bottomSheetButton(context, 16, constants.block, () {block();})
                        ],
                        ), 
              );
            });
}

Widget bottomSheetButton(BuildContext context, int divideHeight, Map<String, String> optionType, Function pressed){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / divideHeight,
    child: ElevatedButton(
    onPressed: () { 
      showDialog(
        context: context, 
        builder: (context) => DeleteReportBlockAlert(
      buttonText: optionType['alertButtonText']!, 
      message: optionType['message']!, 
      subMessage: optionType['subMessage']!, 
      onPressed: () { 
        pressed();
      }
    ));},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      //elevation: 0,
    ),
    child: Center(
      child: Text(
      optionType['bottomSheetText']!,
      style: const TextStyle(
        color: colors.textColor,
        fontFamily: fonts.font,
      ),
    ),
  )
  ));
}
  

// import 'package:byourside/model/comment.dart';
// import 'package:byourside/model/community_post.dart';
// import 'package:byourside/model/save_data.dart';
// import 'package:byourside/widget/delete_report_block_alert.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:byourside/constants/constants.dart' as constants;
// import 'package:byourside/constants/colors.dart' as colors;
// import 'package:byourside/constants/fonts.dart' as fonts;
// import 'package:byourside/constants/icons.dart' as customIcons;

// final SaveData saveData = SaveData();
  
// Future customBottomSheet(BuildContext context, String postOrComment, String collectionName, bool isPostedUser, String uid, CommunityPostModel? post, CommentModel? comment) {
//   String? deleteID = postOrComment == 'post' ? post!.id : comment!.id;
//   String? reportID = postOrComment == 'post' ? post!.id : comment!.id;
//   String? blockUid = postOrComment == 'post' ? post!.id : comment!.id;
  
//   return showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 height: MediaQuery.of(context).size.height /4,
//                 color: Colors.white,
//                 child: isPostedUser ?
//                         bottomSheetButton(context, 4, constants.delete,
//                                         () => delete(context, postOrComment, post!.category, post.id!, collectionName, deleteID))
//                       : Column(
//                         children: <Widget>[
//                           bottomSheetButton(context, 16, constants.report,
//                                             () => report(context, collectionName, postOrComment, reportID!)),
//                           const Divider(thickness: 1, color: colors.subColor),
//                           bottomSheetButton(context, 16, constants.block,
//                                             () => block(context, postOrComment, uid, blockUid))
//                         ],
//                         ), 
//               );
//             });
// }

// Widget bottomSheetButton(BuildContext context, int divideHeight, Map<String, String> optionType, Function() pressed){
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height / divideHeight,
//     child: ElevatedButton(
//     onPressed: () { 
//       showDialog(
//         context: context, 
//         builder: (context) => DeleteReportBlockAlert(
//       buttonText: optionType['alertButtonText']!, 
//       message: optionType['message']!, 
//       subMessage: optionType['subMessage']!, 
//       onPressed: () { 
//         pressed;
//       }
//     ));},
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.white,
//       //elevation: 0,
//     ),
//     child: Center(
//       child: Text(
//       optionType['bottomSheetText']!,
//       style: const TextStyle(
//         color: colors.textColor,
//         fontFamily: fonts.font,
//       ),
//     ),
//   )
//   ));
// }

// delete(BuildContext context, String postOrComment, String category, String documentID, String collectionName, String? commentID){
//   if (postOrComment == 'post') {
//     Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
//     saveData.deleteCommunityPost(category, documentID);
//   } else {
//     saveData.deleteComment(collectionName, documentID, commentID);
//     Navigator.pop(context);
//   }
// }

// report(BuildContext context, String collectionName, String postOrComment, String id){
//   saveData.report(collectionName, postOrComment, id);
//   Navigator.pop(context);
// }

// block(BuildContext context, String postOrComment, String uid, String? blockUid){
//   if (postOrComment == 'post') {
//     Navigator.pushNamedAndRemoveUntil(
//         context, '/', (_) => false);
//   } else {
//     Navigator.pop(context);
//   }
//   saveData.addBlock(uid, blockUid);
// }
  