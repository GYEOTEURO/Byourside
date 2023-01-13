import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FreqQuestion extends StatefulWidget {
  const FreqQuestion({super.key});

  @override
  State<FreqQuestion> createState() => _FreqQuestionState();
}

class _FreqQuestionState extends State<FreqQuestion> {
  final List<String> _questions = <String>[
    "1. '곁'은 어떤 앱인가요?",
    "2. 마음 온도의 기능은 무엇인가요?",
    "3. 마음 나눔의 기능은 무엇인가요?",
    "4. 마음 온도와 마음 나눔에서 왼쪽 위 버튼은 무슨 기능인가요?",
    "5. 마음 온도에서 여러 게시판을 선택할 수 있는데 뭐가 다른가요?"
  ];
  final List<String> _answers = <String>[
    "'곁'은 발달장애와 뇌병변장애 아동의 보호자에게 소통의 공간을 제공하는 어플리케이션입니다.",
    "마음 온도는 커뮤니티 기능으로 또래 자녀를 둔 많은 보호자들이 유용한 정보를 공유할 수 있는 장을 제공합니다. 자녀가 선천적 또는 후천적으로 장애를 얻게 되었을 때 보편적으로 대응방안을 알고 있는 경우는 흔하지 않습니다. 이때 커뮤니티에서 쉽게 유의미한 정보를 얻을 수 있습니다. 학습해야 할 사항이나 관련 혜택, 제도가 존재하는지 등의 정보를 얻을 수 있을 것입니다. 또한, 어린 자녀를 둔 부모는 자신의 자녀의 행동이 단순히 발달이 늦는것인지, 장애의 초기 징후인지에 대한 판별에 많은 정보를 요구합니다. 이때 커뮤니티 기능은 또래 자녀를 둔 많은 보호자가 그들의 경험, 초기 징후를 발견할 수 있는 유용한 정보를 공유할 수 있는 장을 제공합니다.",
    "마음 나눔은 보조기, 보청기, 점자 책과 같이 장애 자녀들이 사용하는 보조 기구들을 나눔하거나 거래할 수 있는 기능입니다. 마음나눔 기능 부분에서도 장애 종류 별 카테고리를 만들어 불필요한 거래 제안은 제외하고 볼 수 있도록 합니다. 기본 정렬 순서는 최신 거래 순서이며, 검색을 통해 관심있는 거래를 찾고자 하는 경우 해당 단어가 포함된 게시글 중 거래가 완료되지 않은 글을 볼 수 있습니다. ",
    "이는 ‘게시글 필터링’으로, 이를 통해 자신이 관심있는 장애 유형을 선택할 수 있으며, 이에 따라 필터링 된 게시글들만 화면에 보여지게끔 설정할 수 있습니다.",
    "‘게시판’의 경우 전체게시판, 자유게시판, 정보게시판으로 나눠져있고, 정보게시판은 비슷한 성격의(전체 정보 게시판, 복지/혜택, 병원/센터 후기, 교육/세미나, 법률/제도, 초기 증상 발견/생활 속 Tip) 게시글들이 모여있습니다."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("자주 묻는 질문",
              semanticsLabel: '자주 묻는 질문',
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.w600)),
          centerTitle: true,
          backgroundColor: Color(0xFF045558),
          leading: IconButton(
            onPressed: () {
              HapticFeedback.lightImpact(); // 약한 진동
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              semanticLabel: '뒤로가기',
            ),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            scrollDirection: Axis.vertical,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // 1번
                Text(_questions[0],
                    semanticsLabel: _questions[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Text(_answers[0],
                    semanticsLabel: _answers[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Divider(thickness: 1, height: 1, color: Colors.black26),
                SizedBox(height: 20),
                // 2번
                Text(_questions[1],
                    semanticsLabel: _questions[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Text(_answers[1],
                    semanticsLabel: _answers[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Divider(thickness: 1, height: 1, color: Colors.black26),
                SizedBox(height: 20),
                // 3번
                Text(_questions[2],
                    semanticsLabel: _questions[2],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Text(_answers[2],
                    semanticsLabel: _answers[2],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Divider(thickness: 1, height: 1, color: Colors.black26),
                SizedBox(height: 20),
                // 4번
                Text(_questions[3],
                    semanticsLabel: _questions[3],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Text(_answers[3],
                    semanticsLabel: _answers[3],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Divider(thickness: 1, height: 1, color: Colors.black26),
                SizedBox(height: 20),
                // 5번
                Text(_questions[4],
                    semanticsLabel: _questions[4],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 10),
                Text(_answers[4],
                    semanticsLabel: _answers[4],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'NanumGothic')),
                SizedBox(height: 30),
              ],
            ))));
  }
}
