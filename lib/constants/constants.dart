/* 
constants.dart : 앱에서 사용하는 각종 상수 값을 정리한 파일
- 상수명 lowerCamelCase 스타일 따름 (Dart 권장 : PREFER using lowerCamelCase for constant names)
*/

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

