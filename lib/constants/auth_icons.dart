import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIcons {
  static final beeIcon = SvgPicture.asset(
    'assets/icons/authentication/bee_icon.svg',
    semanticsLabel: 'bee icon',
  );

  static final beesideLogo = SvgPicture.asset(
    'assets/icons/authentication/beeside_logo.svg',
    semanticsLabel: 'beeside logo',
  );

  static final googleIcon = Image.asset(
    'assets/icons/authentication/google_icon.png',
    semanticLabel: 'Google 아이콘',
  );

  static final appleIcon = SvgPicture.asset(
    'assets/icons/authentication/apple_icon.svg',
    semanticsLabel: 'Apple 아이콘',
  );

  static final tosLine = SvgPicture.asset(
    'assets/icons/authentication/tos_line.svg',
    semanticsLabel: '이용약관 라인',
  );

  static final policyLine = SvgPicture.asset(
    'assets/icons/authentication/policy_line.svg',
    semanticsLabel: '개인정보 처리방침 라인',
  );

}