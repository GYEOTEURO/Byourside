/* 
constants.dart : 앱에서 사용하는 각종 상수 값을 정리한 파일
- 상수명 lowerCamelCase 스타일 따름 (Dart 권장 : PREFER using lowerCamelCase for constant names)
*/

import 'dart:ui';
import 'package:flutter/material.dart';

// 폰트
const font = 'NanumGothic';

// 색상
const Color mainColor = Color(0xFF045558);

// 제목 및 타이틀
const String communityAddPostTitle = "커뮤니티 글쓰기";
const String communityTitle = "커뮤니티";

//post
const List<String> postReportReasonList = [
  '불법 정보를 포함하고 있습니다.',
  '게시판 성격에 부적절합니다.',
  '음란물입니다.',
  '스팸홍보/도배글입니다.',
  '욕설/비하/혐오/차별적 표현을 포함하고 있습니다.',
  '청소년에게 유해한 내용입니다.',
  '사칭/사기입니다.',
  '상업적 광고 및 판매글입니다.'
];

//comment
const List<String> commentReportReasonList = [
  '불법 정보를 포함하고 있습니다.',
  '음란물입니다.',
  '스팸홍보/도배글입니다.',
  '욕설/비하/혐오/차별적 표현을 포함하고 있습니다.',
  '청소년에게 유해한 내용입니다.',
  '사칭/사기입니다.',
  '상업적 광고 및 판매 댓글입니다.'
];

List<String> communityCategories = ['전체', '교육', '기관', '복지', '일상', '행정', '홍보'];