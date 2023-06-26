import 'package:byourside/constants.dart' as constants;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/save_data.dart';

class MyBlock extends StatefulWidget {
  const MyBlock({Key? key}) : super(key: key);
  final Color primaryColor = constants.mainColor;
  final String title = '사용자 차단';

  @override
  State<MyBlock> createState() => _MyBlockState();
}

class _MyBlockState extends State<MyBlock> {
  final TextEditingController _nickname = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final User? user = FirebaseAuth.instance.currentUser;
  final SaveData saveData = SaveData();

  Widget _buildListItem(List<String> blockList) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formkey,
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: const Text(
                      '사용자를 차단하면, 해당 사용자가 작성한 \n글/댓글/채팅이 모두 보이지 않습니다.',
                      semanticsLabel:
                          '사용자를 차단하면, 해당 사용자가 쓴 글/댓글/채팅이 모두 보이지 않습니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w600,
                      ))),
              Semantics(
                  label: '차단할 닉네임 입력',
                  child: TextFormField(
                      controller: _nickname,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '차단할 닉네임은 비어있을 수 없습니다';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: '차단할 닉네임 입력',
                        labelText: '차단할 닉네임을 입력해주세요.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF045558)),
                        ),
                        labelStyle: TextStyle(color: Color(0xFF045558)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF045558)),
                        ),
                      ))),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                  child: const Text('차단한 사용자 목록',
                      semanticsLabel: '차단한 사용자 목록',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: constants.font,
                        fontWeight: FontWeight.w600,
                      ))),
              if (blockList.isEmpty)
                const Center(
                    child: Text('없음',
                        semanticsLabel: '차단한 사용자 목록 없음',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: constants.font,
                          fontWeight: FontWeight.w600,
                        )))
              else
                Column(
                    children: blockList
                        .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$e ',
                                      semanticsLabel: e,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: constants.font,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.primaryColor,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        HapticFeedback.lightImpact(); // 약한 진동
                                        saveData.cancelBlock(user!.uid, e);
                                      },
                                      child: const Text('차단 해제',
                                          semanticsLabel: '차단 해제',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: constants.font,
                                            fontWeight: FontWeight.w600,
                                          )))
                                ]))
                        .toList())
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title,
            semanticsLabel: widget.title,
            style: const TextStyle(
                fontFamily: constants.font, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF045558),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                semanticLabel: '뒤로 가기', color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(user!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            List<String> blockList = [];
            if (snapshot.hasData) {
              blockList = snapshot.data!['blockList'].cast<String>();
            }
            return _buildListItem(blockList);
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: widget.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formkey.currentState!.validate()) {
              saveData.addBlock(user!.uid, _nickname.text);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        semanticLabel:
                            '정상적으로 차단되었습니다. 해당 사용자의 글/댓글/채팅은 보이지 않습니다. 이전 화면으로 이동하려면 확인 버튼을 누르세요.',
                        content: const Text(
                            '정상적으로 차단되었습니다.\n해당 사용자의 글/댓글/채팅은 보이지 않습니다.',
                            semanticsLabel:
                                '정상적으로 차단되었습니다. 해당 사용자의 글/댓글/채팅은 보이지 않습니다.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: constants.font,
                              fontWeight: FontWeight.w600,
                            )),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact(); // 약한 진동
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                              },
                              child: const Text('확인',
                                  semanticsLabel: '확인',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: constants.font,
                                    fontWeight: FontWeight.w600,
                                  )))
                        ]);
                  });
            }
          },
          child: const Text('차단',
              semanticsLabel: '차단',
              style: TextStyle(
                fontSize: 14,
                fontFamily: constants.font,
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
