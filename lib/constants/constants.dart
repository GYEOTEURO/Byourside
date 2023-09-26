/* 
constants.dart : 앱에서 사용하는 각종 상수 값을 정리한 파일
- 상수명 lowerCamelCase 스타일 따름 (Dart 권장 : PREFER using lowerCamelCase for constant names)
*/

import 'package:byourside/constants/text.dart';
import 'package:byourside/screen/authenticate/policy.dart';
import 'package:byourside/screen/mypage/my_block_user.dart';
import 'package:byourside/screen/mypage/my_community_post.dart';
import 'package:byourside/screen/common/my_scrap.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/screen/mypage/setting.dart';

// 버튼
double buttonBorderWidth = 0.50;

// 소통 카테고리
List<String> communityCategories = ['전체', '교육', '기관', '복지', '일상', '행정', '홍보'];
List<String> communityDisabilityTypes = ['전체', '발달', '뇌병변'];
Map<String, String> addPostText = {
  'disabilityType': '장애유형',
  'category': '어떤 종류의 글을 쓰실 건가요?',
  'photo': '사진 추가하기',
};

// 소통 글쓰기 경고 메시지
Map<String, String> warningMessage = {
  'category': '카테고리는 비워둘 수 없습니다. \n카테고리를 선택해주세요.',
  'disabilityType': '장애유형은 비워둘 수 없습니다. \n장애유형을 선택해주세요.',
  'title': '제목은 비워둘 수 없습니다. \n제목을 입력해주세요.',
  'image': '설명이 없는 이미지가 있습니다. \n이미지 내용을 입력해주세요.'
};

// 정보 카테고리
List<String> autoInformationCategories = [
  '전체',
  '교육/활동',
  '돌봄 서비스',
  '보조기기',
  '지원금',
];


List<Map<String, dynamic>> myActivity = [
  {'name': '스크랩한 게시물', 'page': const MyScrap()},
  {'name': '내가 쓴 게시물', 'page': const MyCommunityPost()}
];

List<Map<String, dynamic>> etc = [
  {'name': '설정', 'page': Setting(options: setting)},
  // {
  //   'name' : '개발자에게 문의하기',
  //   'page' : ToDeveloper()
  // },
  {
    'name': '로그아웃',
    'action': handleLogoutAction,
  }
];

List<Map<String, dynamic>> setting = [
  {'name': '차단목록', 'page': const MyBlock()},
  {'name': '개인정보처리방침', 'page': Policy(policy: personalData)},
  {'name': '서비스 이용약관', 'page': Policy(policy: usingPolicy)},
  {
    'name': '탈퇴하기',
    'action': handleDeleteAction,
  }
];
