import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final beeIcon = SvgPicture.asset(
  'assets/icons/authentication/login/bee_icon.svg',
  semanticsLabel: 'bee icon',
);

final beesideLogo = SvgPicture.asset(
  'assets/icons/authentication/login/beeside_logo.svg',
  semanticsLabel: 'beeside logo',
);

final googleIcon = Image.asset(
  'assets/icons/authentication/login/google_icon.png',
  semanticLabel: 'Google 아이콘',
);

final appleIcon = SvgPicture.asset(
  'assets/icons/authentication/login/apple_icon.svg',
  semanticsLabel: 'Apple 아이콘',
);

final tosLine = SvgPicture.asset(
  'assets/icons/authentication/login/tos_line.svg',
  semanticsLabel: '이용약관 라인',
);

final policyLine = SvgPicture.asset(
  'assets/icons/authentication/login/policy_line.svg',
  semanticsLabel: '개인정보 처리방침 라인',
);

Map<String, Widget> iconMap = {
  '종사자': SvgPicture.asset(
    'assets/icons/authentication/setup/participator.svg',
    semanticsLabel: '종사자'
  ),
  '장애 아동 보호자': SvgPicture.asset(
    'assets/icons/authentication/setup/protector.svg',
    semanticsLabel: '장애 아동 보호자'
    ),
  '장애인': SvgPicture.asset(
    'assets/icons/authentication/setup/self.svg',
    semanticsLabel: '장애인'
    ),
};