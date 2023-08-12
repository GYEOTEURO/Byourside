import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byourside/main.dart';

class SetupUser extends StatefulWidget {
  const SetupUser({Key? key}) : super(key: key);

  @override
  _SetupUserState createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  String selectedOption = '';

  bool isOptionSelected(String option) {
    return selectedOption == option;
  }

  bool isProtectorSelected() {
    return selectedOption == '장애 아동 보호자';
  }

  bool isDisabilitySelected() {
    return selectedOption == '장애인';
  }

  bool isWorkerSelected() {
    return selectedOption == '종사자';
  }

  bool isNoOptionSelected() {
    return selectedOption == '해당 사항이 없어요';
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: const Text(
        '프로필을 완성해주세요',
        semanticsLabel: '프로필을 완성해주세요',
        style: TextStyle(
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: primaryColor,
    );
  }

    Widget buildDescriptionText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text) {
    return Expanded(
      child: Material(
        elevation: isOptionSelected(text) ? 10.0 : 5.0,
        borderRadius: BorderRadius.circular(20.0),
        color: isOptionSelected(text)
            ? Colors.orange // Change the color for selected state
            : Theme.of(context).primaryColor,
        child: MaterialButton(
          padding: const EdgeInsets.all(20.0),
          onPressed: () {
            HapticFeedback.lightImpact();
            setState(() {
              selectedOption = text;
            });
          },
          child: Text(
            text,
            semanticsLabel: text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget buildNoOptionButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        setState(() {
          selectedOption = '해당 사항이 없어요';
        });
      },
      color: isOptionSelected('해당 사항이 없어요')
          ? Colors.orange // Change the color for selected state
          : Theme.of(context).primaryColor,
      elevation: isOptionSelected('해당 사항이 없어요') ? 10.0 : 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(20.0),
      minWidth: double.infinity,
      child: const Text(
        '해당 사항이 없어요',
        semanticsLabel: '해당 사항이 없어요',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildDescriptionText('어떤 유형의 사용자인지 알려주세요'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(context, '장애 아동 보호자'),
                      buildButton(context, '장애인'),
                      buildButton(context, '종사자'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildNoOptionButton(context),
                  const SizedBox(height: 20),
                  Text(
                    'Selected option: $selectedOption',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: isProtectorSelected(),
                    child: buildDescriptionText('아동의 장애 종류를 선택해주세요'),
                  ),
                  Visibility(
                    visible: isDisabilitySelected(),
                    child: buildDescriptionText('장애 종류를 선택해주세요'),
                  ),
                  Visibility(
                    visible: isWorkerSelected(),
                    child: buildDescriptionText('종사자 유형을 선택해주세요'),
                  ),
                  Visibility(
                    visible: isNoOptionSelected(),
                    child: buildDescriptionText('해당 사항이 없어요'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}