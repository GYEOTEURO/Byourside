import 'package:cloud_firestore/cloud_firestore.dart';

class ChatList {
  final String? uid;
  ChatList({this.uid});

  // reference for our collection
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  // Future savingUserData(String displayName, String email) async {
  //   return await userCollection.doc(uid).update({
  //     "groups": [],
  //     "profilePic": "",
  //   });
  // }

  // getting user data
  Future gettingUserData(String uid) async {
    QuerySnapshot snapshot = await userCollection.where(uid).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    
    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }
}