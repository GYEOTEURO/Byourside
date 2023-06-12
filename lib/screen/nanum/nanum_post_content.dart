import 'package:byourside/model/chat_list.dart';
import 'package:byourside/screen/common/block_user.dart';
import 'package:byourside/screen/chat/chat_page.dart';
import 'package:byourside/screen/common/report.dart';
import 'package:byourside/screen/common/delete.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../model/load_data.dart';
import '../../model/save_data.dart';
import '../../model/nanum_post.dart';

class NanumPostContent extends StatefulWidget {
  const NanumPostContent(
      {super.key,
      required this.collectionName,
      required this.documentID,
      required this.primaryColor});

  final String collectionName;
  final String documentID;
  final Color primaryColor;

  @override
  State<NanumPostContent> createState() => _NanumPostContentState();
}

class _NanumPostContentState extends State<NanumPostContent> {
  final User? user = FirebaseAuth.instance.currentUser;
  int _current = 0; // 현재 이미지 인덱스

  final List<String> _decList = [
    '불법 정보를 포함하고 있습니다.',
    '게시판 성격에 부적절합니다.',
    '음란물입니다.',
    '스팸홍보/도배글입니다.',
    '욕설/비하/혐오/차별적 표현을 포함하고 있습니다.',
    '청소년에게 유해한 내용입니다.',
    '사칭/사기입니다.',
    '상업적 광고 및 판매글입니다.'
  ];

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<bool> checkGroupExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(name).get();
    return doc.exists;
  }

  Future<String> getGroupId(String groupName) async {
    var collection = FirebaseFirestore.instance.collection('groupList');
    var doc = await collection.doc(groupName).get();
    return doc.data()?.values.last;
  }

  Widget _buildListItem(String? collectionName, NanumPostModel? post) {
    List<String> datetime = post!.datetime!.toDate().toString().split(' ');
    String date = datetime[0].replaceAll('-', '/');
    String hour = datetime[1].split(':')[0];
    String minute = datetime[1].split(':')[1];

    String changeState = post.isCompleted! ? '거래중으로 변경' : '거래완료로 변경';
    String dealState = post.isCompleted! ? '거래완료' : '거래중';

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? type;
    if (post.type!.length == 1) {
      type = post.type![0];
    } else if (post.type!.length > 1) {
      post.type!.sort();
      type = '${post.type![0]}/${post.type![1]}';
    }

    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: SelectionArea(
              child: Text(
            ' ${post.title!}',
            semanticsLabel: post.title,
            style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'NanumGothic'),
          ))),
      Row(children: [
        Expanded(
            child: TextButton(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  post.type!.isEmpty
                      ? '${post.nickname!} | $date $hour:$minute'
                      : '${post.nickname!} | $date $hour:$minute | $type',
                  semanticsLabel: post.type!.isEmpty
                      ? "${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $hour시 $minute분"
                      : "${post.nickname!}  ${date.split('/')[0]}년 ${date.split('/')[1]}월 ${date.split('/')[2]}일 $hour시 $minute분  $type",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w600))),
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            var groupName = '${user?.displayName}_${post.nickname}';
            var groupNameReverse = '${post.nickname}_${user?.displayName}';
            if (await checkGroupExist(groupName) != true &&
                await checkGroupExist(groupNameReverse) != true) {
              await ChatList(uid: FirebaseAuth.instance.currentUser!.uid)
                  .createGroup(
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
                      FirebaseAuth.instance.currentUser!.uid.toString(),
                      post.nickname!,
                      post.uid!,
                      groupName);

              String groupId = await getGroupId(groupName);
              await groupCollection.doc(groupId).update({
                'members':
                    FieldValue.arrayUnion(['${post.uid}_${post.nickname}'])
              });
              // await userCollection.doc(post.uid).update({
              //   "groups":
              //       FieldValue.arrayUnion(["${doc.uid}_${doc.nickname}"])
              // })
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            groupId: groupId,
                            groupName: groupName,
                            userName: user!.displayName!)));
              });
            } else if (await checkGroupExist(groupName) != true) {
              String groupId = await getGroupId(groupNameReverse);
              await groupCollection.doc(groupId).update({
                'members':
                    FieldValue.arrayUnion(['${user?.uid}_${user?.displayName}'])
              });
              await userCollection.doc(user?.uid).update({
                'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
              });
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            groupId: groupId,
                            groupName: groupNameReverse,
                            userName: user!.displayName!)));
              });
            } else {
              String groupId = await getGroupId(groupName);
              await groupCollection.doc(groupId).update({
                'members':
                    FieldValue.arrayUnion(['${user?.uid}_${user?.displayName}'])
              });
              await userCollection.doc(user?.uid).update({
                'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
              });
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            groupId: groupId,
                            groupName: groupName,
                            userName: user!.displayName!)));
              });
            }
          },
        )),
        if (user?.uid == post.uid)
          Delete(collectionName: widget.collectionName, documentID: widget.documentID)
        else
          Row(children: [
            Report(
                decList: _decList, collectionType: 'post', id: post.id!),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BlockUser(nickname: post.nickname!, collectionType: 'post')),
          ])
      ]),
      const Divider(thickness: 1, height: 1, color: Colors.black),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        (post.price == '0')
            ? Container(
                width: width * 0.6,
                alignment: Alignment.center,
                child: const SelectionArea(
                    child: Text('나눔',
                        semanticsLabel: '나눔',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 223, 113, 93),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NanumGothic'))))
            : Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: width * 0.5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SelectionArea(
                          child: Text('가격',
                              semanticsLabel: '가격',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 223, 113, 93),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'NanumGothic'))),
                      SelectionArea(
                          child: Text(
                        '${post.price!} 원',
                        semanticsLabel: '${post.price!} 원',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 223, 113, 93),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NanumGothic'),
                      )),
                    ])),
        if (user?.uid == post.uid)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 113, 93),
              ),
              child: Text(changeState,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500)),
              onPressed: () {
                HapticFeedback.lightImpact(); // 약한 진동
                SaveData.updateIsCompleted(
                    collectionName!, post.id!, !post.isCompleted!);
              })
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 223, 113, 93),
            ),
            child: Text(dealState,
                semanticsLabel: dealState,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w500)),
            onPressed: () {},
          ),
      ]),
      const Divider(thickness: 1, height: 1, color: Colors.grey),
      if (post.images!.isNotEmpty)
        Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: CarouselSlider(
                  items: List.generate(post.images!.length, (index) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Semantics(
                            label: post.imgInfos![index],
                            child: Image.network(post.images![index])));
                  }),
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.5,
                      initialPage: 0,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      aspectRatio: 2.0,
                      onPageChanged: (idx, reason) {
                        setState(() {
                          _current = idx;
                        });
                      }))),
          Semantics(
            label: '현재 보이는 사진 순서 표시',
            child: CarouselIndicator(
              count: post.images!.length,
              index: _current,
              color: Colors.black26,
              activeColor: widget.primaryColor,
            ),
          ),
        ]),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
          child: SelectionArea(
              child: Text(
            post.content!,
            semanticsLabel: post.content,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600),
          ))),
      //Divider(thickness: 1, height: 1, color: Colors.black),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        OutlinedButton.icon(
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            post.likesPeople!.contains(user?.uid)
                ? SaveData.cancelLike(collectionName!, post.id!, user!.uid)
                : SaveData.addLike(collectionName!, post.id!, user!.uid);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(width * 0.38, height * 0.06),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            side:
                const BorderSide(color: Color.fromARGB(255, 255, 45, 45), width: 1.5),
            foregroundColor: const Color.fromARGB(255, 255, 45, 45),
          ),
          icon: post.likesPeople!.contains(user?.uid)
              ? const Icon(Icons.favorite, semanticLabel: '좋아요 취소')
              : const Icon(Icons.favorite_outline, semanticLabel: '좋아요 추가'),
          label: Text('좋아요  ${post.likes}',
              semanticsLabel: '좋아요  ${post.likes}개',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'NanumGothic',
              )),
        ),
        OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              post.scrapPeople!.contains(user?.uid)
                  ? SaveData.cancelScrap(collectionName!, post.id!, user!.uid)
                  : SaveData.addScrap(collectionName!, post.id!, user!.uid);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width * 0.38, height * 0.06),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              side: const BorderSide(
                  color: Color.fromARGB(255, 64, 130, 75), width: 1.5),
              foregroundColor: const Color.fromARGB(255, 64, 130, 75),
            ),
            icon: post.scrapPeople!.contains(user?.uid)
                ? const Icon(Icons.star, semanticLabel: '스크랩 취소')
                : const Icon(Icons.star_outline, semanticLabel: '스크랩 추가'),
            label: const Text('스크랩',
                semanticsLabel: '스크랩',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontFamily: 'NanumGothic'))),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    String documentID = widget.documentID;

    return StreamBuilder<NanumPostModel>(
        stream: LoadData.readNanumDocument(
            collectionName: collectionName, documentID: documentID),
        builder: (context, AsyncSnapshot<NanumPostModel> snapshot) {
          if (snapshot.hasData) {
            NanumPostModel? post = snapshot.data;
            return _buildListItem(collectionName, post);
          } else {
            return const SelectionArea(
                child: Center(
                    child: Text('게시물을 찾을 수 없습니다.',
                        semanticsLabel: '게시물을 찾을 수 없습니다.',
                        style: TextStyle(
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w600,
                        ))));
          }
        });
  }
}
