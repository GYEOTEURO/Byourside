import 'package:byourside/constants/text.dart';
import 'package:byourside/screen/authenticate/policy.dart';
import 'package:byourside/screen/common/my_scrap.dart';
import 'package:byourside/screen/mypage/my_block_user.dart';
import 'package:byourside/screen/mypage/my_community_post.dart';
import 'package:byourside/screen/mypage/options.dart';
import 'package:byourside/screen/mypage/setting.dart';

List<Map<String, dynamic>> myActivity = [
  {'name': '스크랩한 게시물', 'page': const MyScrap()},
  {'name': '내가 쓴 게시물', 'page': const MyCommunityPost()}
];

List<Map<String, dynamic>> etc = [
  {'name': '설정', 'page': Setting(options: setting)},
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