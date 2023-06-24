import 'package:byourside/main.dart';
import 'package:byourside/model/firebase_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<FormState> _formKeyProtector = GlobalKey<FormState>();

final List<bool> _selectedProtectorGender = <bool>[false, false];
final List<bool> _selectedChildGender = <bool>[false, false];
final List<bool> _selectedChildType = <bool>[false, false];
final List<bool> _selectedChildDegree = <bool>[false, false];

final TextEditingController _nickname = TextEditingController();
final TextEditingController _protectorAge = TextEditingController();
final TextEditingController _childAge = TextEditingController();
final TextEditingController _belong = TextEditingController();

const List<Widget> gender = <Widget>[
  Text('남자', semanticsLabel: '남자', style: TextStyle(fontSize: 17)),
  Text('여자', semanticsLabel: '여자', style: TextStyle(fontSize: 17))
];
const List<Widget> type = <Widget>[
  Text('뇌병변 장애', semanticsLabel: '뇌병변 장애', style: TextStyle(fontSize: 17)),
  Text('발달 장애', semanticsLabel: '발달 장애', style: TextStyle(fontSize: 17))
];
const List<Widget> degree = <Widget>[
  Text('심한 장애', semanticsLabel: '심한 장애', style: TextStyle(fontSize: 17)),
  Text('심하지 않은 장애', semanticsLabel: '심하지 않은 장애', style: TextStyle(fontSize: 17))
];

class Protector extends StatefulWidget {
  const Protector({Key? key}) : super(key: key);

  @override
  State<Protector> createState() => _ProtectorState();
}

class _ProtectorState extends State<Protector> {
  bool doesDocExist = true;
  final User? user = FirebaseAuth.instance.currentUser;
  bool protector = true;
  bool isUserDataStored = false;

  Future<bool> checkDocExist(String name) async {
    var collection = FirebaseFirestore.instance.collection('displayNameList');
    var doc = await collection.doc(name).get();
    if (doc.exists == true) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  semanticLabel:
                      '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요. 돌아가려면 하단의 확인 버튼을 눌러주세요.',
                  content: const Text(
                    '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                    semanticsLabel: '이미 존재하는 닉네임입니다. 다른 닉네임을 사용하세요.',
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact(); // 약한 진동
                          Navigator.pop(context);
                        },
                        child: const Text('확인',
                            semanticsLabel: '확인',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600,
                            )))
                  ]);
            });
      }
    } else {
      if (mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                semanticLabel: '사용가능한 닉네임입니다. 돌아가려면 하단의 확인 버튼을 눌러주세요.',
                content: const Text(
                  '사용가능한 닉네임입니다.',
                  semanticsLabel: '사용가능한 닉네임입니다.',
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact(); // 약한 진동
                        Navigator.pop(context);
                      },
                      child: const Text('확인',
                          semanticsLabel: '확인',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w600,
                          )))
                ]);
          });}
    }
    return doc.exists;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  final nicknameField = Semantics(
      container: true,
      textField: true,
      label: '닉네임',
      hint: '(예: 홍길동)',
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '닉네임',
          hintText: '(예: 홍길동) ',
          floatingLabelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 22,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          errorStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 45, 45),
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 255, 45, 45)),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        autofocus: true,
        controller: _nickname,
        validator: (value) {
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              if (value[i] == '_') {
                return '특수기호 _는 포함이 불가능합니다.';
              }
            }
            if (value.split(' ').first != '' && value.isNotEmpty) {
              return null;
            }
            return '필수 입력란입니다. 닉네임을 입력하세요';
          }
          return null;
        },
      ));

  void storeProtectorInfo(
      String? nickname,
      String? protectorAge,
      List<bool>? selectedProtectorGender,
      String? childAge,
      List<bool>? selectedChildGender,
      List<bool>? selectedChildType,
      List<bool>? selectedChildDegree,
      String? belong) async {
    // image url 포함해 firestore에 document 저장
    FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
      'nickname': nickname,
      'protectorAge': protectorAge,
      'protectorGender': selectedProtectorGender,
      'childAge': childAge,
      'childGender': selectedChildGender,
      'childType': selectedChildType,
      'childDegree': selectedChildDegree,
      'belong': belong,
      'groups': [],
      'profilePic': '',
      'blockList': [],
    });
    FirebaseFirestore.instance
        .collection('displayNameList')
        .doc('$nickname')
        .set({'current': true});
    if (user != null) {
      await user?.updateDisplayName(nickname);
      FirebaseUser(uid: user?.uid, displayName: nickname);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('세부 정보 입력',
              semanticsLabel: '세부 정보 입력',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  semanticLabel: '뒤로 가기', color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 50, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '3/4 단계',
                    semanticsLabel: '3/4 단계',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Form(
                key: _formKeyProtector,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          '닉네임을 입력하세요.',
                          semanticsLabel: '닉네임을 입력하세요.',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height * 0.01),
                        const Text(
                          "특수기호 '_'는 사용이 불가합니다.",
                          semanticsLabel: '특수기호 _ 는 사용이 불가합니다.',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height * 0.02),
                        nicknameField,
                        SizedBox(height: height * 0.04),
                        const Text(
                          '보호자 나이를 입력하세요.',
                          semanticsLabel: '보호자 나이를 입력하세요.',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height * 0.02),
                        Semantics(
                            container: true,
                            textField: true,
                            label: '보호자 나이',
                            hint: '(예: 33)',
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '보호자 나이',
                                hintText: '(예: 33)',
                                floatingLabelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 22,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 45, 45),
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                labelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 45, 45)),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _protectorAge,
                              validator: (value) {
                                if (value != null) {
                                  if (value.split(' ').first != '' &&
                                      value.isNotEmpty &&
                                      isNumeric(value)) {
                                    return null;
                                  }
                                  return '숫자만 입력 가능합니다.';
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: height * 0.04),
                        const Text(
                          '자녀 나이를 입력하세요.',
                          semanticsLabel: '자녀 나이를 입력하세요.',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height * 0.02),
                        Semantics(
                            container: true,
                            textField: true,
                            label: '자녀 나이',
                            hint: '(예: 7)',
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '자녀 나이',
                                hintText: '(예: 7)',
                                floatingLabelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 22,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 45, 45),
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                labelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 45, 45)),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _childAge,
                              validator: (value) {
                                if (value != null) {
                                  if (value.split(' ').first != '' &&
                                      value.isNotEmpty &&
                                      isNumeric(value)) {
                                    return null;
                                  }
                                  return '숫자만 입력 가능합니다.';
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: height * 0.04),
                        const Text(
                          '소속 복지관/학교를 입력하세요.',
                          semanticsLabel: '소속 복지관/학교를 입력하세요.',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 17,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height * 0.02),
                        Semantics(
                            container: true,
                            textField: true,
                            label: '소속 복지관/학교',
                            hint: '(예: 서울뇌성마비복지관)',
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '소속 복지관/학교',
                                hintText: '(예: 서울뇌성마비복지관)',
                                floatingLabelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 22,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                errorStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 45, 45),
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                labelStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 45, 45)),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              controller: _belong,
                              validator: (value) {
                                if (value != null) {
                                  if (value.split(' ').first != '' &&
                                      value.isNotEmpty) {
                                    return null;
                                  }
                                  return '필수 입력란입니다. 소속을 입력하세요';
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: height * 0.03),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      '보호자 성별',
                                      semanticsLabel: '보호자 성별',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ToggleButtons(
                                      direction: Axis.horizontal,
                                      onPressed: (int index) {
                                        HapticFeedback.lightImpact(); // 약한 진동
                                        setState(() {
                                          _selectedProtectorGender[index] =
                                              true;
                                          _selectedProtectorGender[
                                              (1 - index).abs()] = false;
                                        });
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      selectedBorderColor: primaryColor,
                                      selectedColor: Colors.white,
                                      fillColor: primaryColor,
                                      color: primaryColor,
                                      constraints: BoxConstraints(
                                        minHeight: height * 0.06,
                                        minWidth: width * 0.25,
                                      ),
                                      isSelected: _selectedProtectorGender,
                                      children: gender,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '자녀 성별',
                                        semanticsLabel: '자녀 성별',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'NanumGothic',
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      ToggleButtons(
                                        direction: Axis.horizontal,
                                        onPressed: (int index) {
                                          HapticFeedback.lightImpact(); // 약한 진동
                                          setState(() {
                                            _selectedChildGender[index] = true;
                                            _selectedChildGender[
                                                (1 - index).abs()] = false;
                                          });
                                        },
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        selectedBorderColor: primaryColor,
                                        selectedColor: Colors.white,
                                        fillColor: primaryColor,
                                        color: primaryColor,
                                        constraints: BoxConstraints(
                                          minHeight: height * 0.06,
                                          minWidth: width * 0.25,
                                        ),
                                        isSelected: _selectedChildGender,
                                        children: gender,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '장애 유형',
                                      semanticsLabel: '장애 유형',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ToggleButtons(
                                      direction: Axis.horizontal,
                                      onPressed: (int index) {
                                        HapticFeedback.lightImpact(); // 약한 진동
                                        setState(() {
                                          _selectedChildType[index] = true;
                                          _selectedChildType[
                                              (1 - index).abs()] = false;
                                        });
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      selectedBorderColor: primaryColor,
                                      selectedColor: Colors.white,
                                      fillColor: primaryColor,
                                      color: primaryColor,
                                      constraints: BoxConstraints(
                                        minHeight: height * 0.06,
                                        minWidth: width * 0.3,
                                      ),
                                      isSelected: _selectedChildType,
                                      children: type,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '장애 정도',
                                      semanticsLabel: '장애 정도',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'NanumGothic',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ToggleButtons(
                                      direction: Axis.horizontal,
                                      onPressed: (int index) {
                                        HapticFeedback.lightImpact(); // 약한 진동
                                        setState(() {
                                          _selectedChildDegree[index] = true;
                                          _selectedChildDegree[
                                              (1 - index).abs()] = false;
                                        });
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      selectedBorderColor: primaryColor,
                                      selectedColor: Colors.white,
                                      fillColor: primaryColor,
                                      color: primaryColor,
                                      constraints: BoxConstraints(
                                        minHeight: height * 0.06,
                                        minWidth: width * 0.3,
                                      ),
                                      isSelected: _selectedChildDegree,
                                      children: degree,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                            ])),
                      ],
                    )))
          ])
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            HapticFeedback.lightImpact(); // 약한 진동
            if (_formKeyProtector.currentState!.validate() &&
                _nickname.text.split(' ').first != '' &&
                _protectorAge.text.split(' ').first != '' &&
                _childAge.text.split(' ').first != '' &&
                _belong.text.split(' ').first != '' &&
                (_selectedChildDegree[0] || _selectedChildDegree[1]) &&
                (_selectedChildGender[0] || _selectedChildGender[1]) &&
                (_selectedChildType[0] || _selectedChildType[1]) &&
                (_selectedProtectorGender[0] || _selectedProtectorGender[1])) {
              doesDocExist = await checkDocExist(_nickname.text);
              if (doesDocExist == false) {
                storeProtectorInfo(
                    _nickname.text,
                    _protectorAge.text,
                    _selectedProtectorGender,
                    _childAge.text,
                    _selectedChildGender,
                    _selectedChildType,
                    _selectedChildDegree,
                    _belong.text);
                if (mounted) {
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const VerifyEmail()));
              
                }
                }
            }
          },
          backgroundColor: primaryColor,
          child: const Text(
            '완료',
            semanticsLabel: '완료',
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
