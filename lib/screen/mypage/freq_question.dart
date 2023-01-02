import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FreqQuestion extends StatefulWidget {
  const FreqQuestion({super.key});

  @override
  State<FreqQuestion> createState() => _FreqQuestionState();
}

class _FreqQuestionState extends State<FreqQuestion> {
  final List<String> _questions = <String>[
    "1. '곁'은 어떤 앱인가요?'",
    "2. 마음 나눔의 기능은 무엇인가요?",
    "3. 마음 온도의 기능은 무엇인가요?",
    "4. 마음 온도와 나눔에서 왼쪽 위 버튼은 무슨 기능인가요?",
    "5. 마음 온도에서 여러 게시판을 선캑할 수 있는데 뭐가 다른가요?"
  ];
  final List<String> _answers = <String>[
    "'곁'은 장애 아동의 보호자에게 소통의 공간을 제공하는 어플리케이션입니다.",
    // "마음나눔 기능 부분에서도 장애 종류 별 카테고리를 만들어 불필요한 거래 제안은 제외하고 볼 수 있도록 합니다. 기본 정렬 순서는 최신 거래 순서이며, 위치 정보를 제공받아 거리정보 또한 거래 순서에 포함될 수 있습니다. 검색을 통해 관심있는 거래를 찾고자 하는 경우 해당 단어가 포함된 게시글 중 거래가 완료되지 않은 글을 볼 수 있습니다. ",
    // "자녀가 선천적 또는 후천적으로 장애를 얻게 되었을 때 보편적으로 대응방안을 알고 있는 경우는 흔하지 않습니다. 이때 커뮤니티에서 쉽게 유의미한 정보를 얻을 수 있습니다. 학습해야 할 사항이나 관련 혜택, 제도가 존재하는지 등의 정보를 얻을 수 있을 것입니다. 또한, 어린 자녀를 둔 부모는 자신의 자녀의 행동이 단순히 발달이 늦는것인지, 장애의 초기 징후인지에 대한 판별에 많은 정보를 요구합니다. 이때 커뮤니티 기능은 또래 자녀를 둔 많은 보호자가 그들의 경험, 초기 징후를 발견할 수 있는 유용한 정보를 공유할 수 있는 장을 제공합니다.",
    // "이는 ‘게시글 필터링’으로, 이를 통해 자신이 관심있는 장애 종류와 등급을 선택할 수 있으며, 이에 따라 필터링 된 게시글들만 화면에 보여지게끔 설정할 수 있습니다.",
    // "‘게시판’의 경우 전체게시판, 공지사항, 자유게시판, 정보게시판으로 나눠져있고, 정보게시판은 비슷한 성격의 게시글들이 모여있습니다."
    "gg", "ggggg", "ggggggg", "sss"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("자주 묻는 질문"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            child: Center(
                child: Expanded(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: _questions.length,
                        itemBuilder: (BuildContext context, index) {
                          return Expanded(
                              child: Column(
                            children: [
                              Container(
                                child: Text(_questions[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                  child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      strutStyle: StrutStyle(fontSize: 12),
                                      text: TextSpan(text: _answers[index])))
                            ],
                          ));
                        })),
                SizedBox(
                  height: 20,
                ),
              ],
            )))));
  }
}
