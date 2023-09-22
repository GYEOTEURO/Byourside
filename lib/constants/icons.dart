import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:byourside/constants/colors.dart' as colors;

// bottomNavigationBar
final autoInformation =
    SvgPicture.asset('assets/icons/auto_information.svg', semanticsLabel: '정보');

final autoInformationBgr = SvgPicture.asset(
    'assets/icons/auto_information_bgr.svg',
    semanticsLabel: '정보');

final community =
    SvgPicture.asset('assets/icons/community.svg', semanticsLabel: '소통');

final communityBgr =
    SvgPicture.asset('assets/icons/community_bgr.svg', semanticsLabel: '소통');

final home = SvgPicture.asset('assets/icons/home.svg', semanticsLabel: '홈');

final homeBgr =
    SvgPicture.asset('assets/icons/home_bgr.svg', semanticsLabel: '홈');

final myPage =
    SvgPicture.asset('assets/icons/mypage.svg', semanticsLabel: '마이');

final myPageBgr =
    SvgPicture.asset('assets/icons/mypage_bgr.svg', semanticsLabel: '마이');

// common
final gotoScrapPage = SvgPicture.asset('assets/icons/scrap_page.svg',
    semanticsLabel: '스크랩 페이지로 이동');

final search =
    SvgPicture.asset('assets/icons/search.svg', semanticsLabel: '검색');

// community
final addPost =
    SvgPicture.asset('assets/icons/add_post.svg', semanticsLabel: '커뮤니티 글쓰기');

final communityPostListLikes =
    SvgPicture.asset('assets/icons/likes.svg', semanticsLabel: '좋아요');

final communityPostListScraps =
    SvgPicture.asset('assets/icons/scrap.svg', semanticsLabel: '스크랩');

final communityPostLikesEmpty =
    SvgPicture.asset('assets/icons/post_likes.svg', semanticsLabel: '좋아요');

final communityPostLikesFull =
    SvgPicture.asset('assets/icons/post_likes_full.svg', semanticsLabel: '좋아요');

final communityPostScrapsEmpty =
    SvgPicture.asset('assets/icons/post_scrap.svg', semanticsLabel: '스크랩');

final communityPostScrapsFull =
    SvgPicture.asset('assets/icons/post_scrap_full.svg', semanticsLabel: '스크랩');

final back = SvgPicture.asset('assets/icons/back.svg', semanticsLabel: '뒤로가기');

final postOption =
    SvgPicture.asset('assets/icons/option.svg', semanticsLabel: '옵션');

final commentOption =
    SvgPicture.asset('assets/icons/option.svg', semanticsLabel: '옵션', colorFilter: ColorFilter.mode(colors.subColor, BlendMode.srcIn));

final profile =
    SvgPicture.asset('assets/icons/profile.svg', semanticsLabel: '프로필사진');

final hobee =
    SvgPicture.asset('assets/icons/hobee.svg', semanticsLabel: '호비캐릭터사진');

final logo = SvgPicture.asset('assets/icons/logo.svg', semanticsLabel: '로고사진');

final seeMore =
    SvgPicture.asset('assets/icons/see_more.svg', semanticsLabel: '더보기버튼');

final speechBubble =
    SvgPicture.asset('assets/icons/speech_bubble.svg', semanticsLabel: '말풍선');

final loading = Image.asset(
  'assets/icons/loading.gif',
);

final photo = Image.asset(
  'assets/icons/photo.svg',
);

final site = Image.asset(
  'assets/icons/site.svg',
  semanticLabel: '사이트',
);
