import 'package:byourside/screen/authenticate/social_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/pages.dart' as pages;
import 'package:byourside/constants/colors.dart' as colors;

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: 
        pages.onboardingIconDescription.map((page) =>
          PageViewModel(
            //title: 'Beeside',
            //body: page['description'],
            titleWidget: const Text('Beeside',
              semanticsLabel: 'Beeside', 
              style: TextStyle(
                color: colors.textColor,
                fontFamily: fonts.font,
                fontWeight: FontWeight.w600
            )),
            bodyWidget: Text(page['description'],
              semanticsLabel: page['description'],
              style: const TextStyle(
                color: colors.textColor,
                fontFamily: fonts.font,
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),
            image: page['icon'],
            decoration: const PageDecoration(
              pageColor: colors.lightPrimaryColor,
              titleTextStyle: TextStyle(
                color: colors.textColor,
                fontFamily: fonts.font,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ).toList()
      ,
      done: const Text('시작하기',
        semanticsLabel: '시작하기', 
        style: TextStyle(
          color: colors.textColor,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w600
      )),
      onDone: () { Get.offAll(() => const SocialLogin()); },
      baseBtnStyle: TextButton.styleFrom(
        backgroundColor: colors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),  
      showSkipButton: true,
      skip: const Text('로그인',
        semanticsLabel: '로그인', 
        style: TextStyle(
          color: colors.textColor,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w600
      )),
      onSkip: () { Get.offAll(() => const SocialLogin()); },
      showBackButton: false,
      next: const Text('다음',
        semanticsLabel: '다음',
        style: TextStyle(
          color: colors.textColor,
          fontFamily: fonts.font,
          fontWeight: FontWeight.w600
      )),
      // curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.all(16),
      // controlsPadding: kIsWeb
      //     ? const EdgeInsets.all(12.0)
      //     : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: colors.bgrColor,
        activeColor: colors.primaryColor,
        shape: OvalBorder(),
      ),
    );
  }
}