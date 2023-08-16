import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byourside/constants/colors.dart' as colors;
import 'package:byourside/constants/fonts.dart' as fonts;

class TimeConvertor extends StatelessWidget {
  final Timestamp createdAt;

  const TimeConvertor({super.key, required this.createdAt});

  String formatTimeAgo(Duration difference) {
    if (difference.inMinutes < 60) {
      if(difference.inMinutes == 0){
        return '방금 전';
      } 
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else {
      // Format as date (month/day)
      DateTime dateTime = createdAt.toDate();
      return '${dateTime.month}/${dateTime.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime createdAtDateTime = createdAt.toDate();
    Duration difference = now.difference(createdAtDateTime);

    return Text(
      formatTimeAgo(difference),
      style: const TextStyle(
        color: colors.subColor,
        fontSize: fonts.createdAtPt,
        fontFamily: fonts.font,
        fontWeight: FontWeight.w400
      )
    );
  }
}

