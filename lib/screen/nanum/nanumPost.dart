import 'package:byourside/screen/nanum/appbar.dart';
import 'package:byourside/screen/nanum/nanumPostContent.dart';
import 'package:byourside/screen/postComment/commentList.dart';
import 'package:byourside/screen/postComment/createComment.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class NanumPost extends StatefulWidget {
  const NanumPost({super.key, required this.collectionName, required this.documentID, required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<NanumPost> createState() => _NanumPostState();
}

class _NanumPostState extends State<NanumPost> {

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("마음나눔"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
            child: Column(
                  children: [
                    Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    child: NanumPostContent(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor)),
                  Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: CreateComment(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor)),
                  Container(
                    margin: EdgeInsets.all(7), 
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: CommentList(
                              collectionName: collectionName,
                              documentID: documentID,
                              primaryColor: primaryColor),
        )]),
        ));
  }
}