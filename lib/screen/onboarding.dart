import 'package:byourside/screen/authenticate/social_login.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:byourside/constants/fonts.dart' as fonts;
import 'package:byourside/constants/pages.dart' as pages;
import 'package:byourside/constants/colors.dart' as colors;

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);
  final _introKey = GlobalKey<IntroductionScreenState>();
  
  Container _nextOrStartButton(double width, double height, String buttonText, Function pressedFunc){
    return Container(
      margin: EdgeInsets.all(width * (0.04)),
      width: width * (0.8),
      height: height * (0.07),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: (){ 
          HapticFeedback.lightImpact();
          pressedFunc(); 
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60), 
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(colors.primaryColor),
        ),
        child: Text(
          buttonText,
          semanticsLabel: buttonText,
          style: const TextStyle(
            fontFamily: fonts.font,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colors.textColor
          ),
        ),
      )
    );
  }

  DotsIndicator _dotsIndicator(double pageIndex){
    return DotsIndicator(
        dotsCount: pages.onboardingIconDescription.length,
        position: pageIndex,
        decorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: colors.bgrColor,
          activeColor: colors.primaryColor,
          shape: OvalBorder(),
      ));
  }


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    
    return IntroductionScreen(
      key: _introKey,
      pages: [ 
        for(int index = 0; index < pages.onboardingIconDescription.length; index++)
          PageViewModel(
            image: Align(
              alignment: Alignment.bottomCenter,
              child: pages.onboardingIconDescription[index]['icon']
            ),
            titleWidget: Text(pages.onboardingIconDescription[index]['description'],
              textAlign: TextAlign.center,
              semanticsLabel: pages.onboardingIconDescription[index]['description'],
              style: const TextStyle(
                color: colors.textColor,
                fontFamily: fonts.font,
                fontSize: 16,
                fontWeight: FontWeight.w400
            )),
            bodyWidget: Column(
                  children: [
                    _dotsIndicator(index.toDouble()),
                    index == (pages.onboardingIconDescription.length - 1) ?
                    _nextOrStartButton(deviceWidth, deviceHeight, '시작하기', () => Get.offAll(() => const SocialLogin()) )
                    : _nextOrStartButton(deviceWidth, deviceHeight, '다음', () => _introKey.currentState?.next() )
            ]),
            decoration: PageDecoration(
              pageColor: colors.lightPrimaryColor,
              contentMargin : EdgeInsets.only(bottom: deviceHeight * 0.01),
              pageMargin : EdgeInsets.only(top: deviceHeight * 0.1),
            ),
          ),
      ],
      hideBottomOnKeyboard: true,
      showSkipButton: false,  
      showDoneButton: false,
      showBackButton: false,
      showNextButton: false,
      customProgress: Container(color: colors.lightPrimaryColor),
    );
  }
}