const String registrationFailedText = 'Registration is Failed';

// 제목 및 타이틀
const String communityAddPostTitle = '글쓰기';
const String communityTitle = '소통 게시판';
const String autoInformationTitle = '정보 게시판';

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

// 신고 메시지
Map<String, String> report = {
  'bottomSheetText': '글 신고',
  'message': '해당 글을 신고하시겠습니까?',
  'subMessage': '*신고된 글은 운영 정책에 따라\n 삭제되거나 이용이 제한될 수 있습니다.',
  'alertButtonText': '신고하기',
};

// 차단 메시지
Map<String, String> block = {
  'bottomSheetText': '작성자 차단',
  'message': '사용자를 차단하시겠습니까?\n차단하면 피드에서 사용자의 글을 볼 수 없습니다.',
  'subMessage': '*마이페이지 설정에서 차단을 해제할 수 있습니다.',
  'alertButtonText': '차단하기',
};

// 차단 해제 메시지
Map<String, String> cancelBlock = {
  'message': '님의 차단을 해제하시겠습니까?',
  'subMessage': '',
  'buttonText': '차단 해제',
};

// 삭제 메시지
Map<String, String> delete = {
  'bottomSheetText': '글 삭제',
  'message': '해당 글을 삭제하시겠습니까?',
  'subMessage': '*삭제 시 복구 불가능합니다.',
  'alertButtonText': '삭제하기',
};

Map<String, String> usingPolicy = {
  'policyName': '서비스 이용약관',
  'policyContent':
      "< 곁으로 >('https://www.instagram.com/gyeoteuro/'이하 '곁으로')은(는) 사용자의 신속하고 원활한 서비스 이용을 위하여 다음과 같이 서비스 이용약관을 수립·공개합니다.\n\n제1조(목적) \n곁 서비스 이용약관은 곁으로(이하 \"회사\"라 합니다)가 제공하는 곁 서비스의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임 사항 등을 규정함을 목적으로 합니다.\n\n 제2조(정의)\n이 약관에서 사용하는 용어의 정의는 다음과 같습니다. \n1.\"서비스\"란, 회사가 제공하는 모든 서비스 및 기능을 말합니다.\n2.\"이용자\"란, 이 약관에 따라 서비스를 이용하는 회원을 말합니다.\n3.\"회원\"이란, 서비스에 회원등록을 하고 서비스를 이용하는 자를 말합니다.\n4.\"게시물\"이란, 서비스에 게재된 사진 등을 말합니다.\n5.\"커뮤니티\"란, 게시물을 게시할 수 있는 공간을 말합니다.\n6.\"이용 기록\"이란, 이용자가 서비스를 이용하면서 직접 생성한 글 및 댓글, 채팅방 및 대화 등을 말합니다.\n7.\"로그 기록\"이란, 이용자가 서비스를 이용하면서 자동으로 생성된 IP 주소, 접속 시간 등을 말합니다.\n8.\"기기 정보\"란, 이용자의 통신 기기에서 수집된 유저 에이전트, ADID 등을 말합니다.\n9.\"계정\"이란, 이용계약을 통해 생성된 회원의 고유 아이디와 이에 수반하는 정보를 말합니다.\n10.\"서비스 내부 알림 수단\"이란, 알림, 1:1 대화, 내 정보 메뉴 등을 말합니다.\n11.\"연락처\"란, 회원가입, 본인 인증, 문의 창구 등을 통해 수집된 이용자의 이메일, 휴대전화 번호 등을 의미합니다.\n12.\"관련법\"이란, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신사업법, 개인정보보호법 등 관련 있는 국내 법령을 말합니다.\n13.\"본인 인증\"이란, 휴대전화 번호 등을 이용한 본인 확인 절차를 말합니다.\n제1항에서 정의되지 않은 이 약관 내 용어의 의미는 일반적인 이용관행에 의합니다.\n\n제3조(약관 등의 명시와 설명 및 개정)\n1. 회사는 이 약관을 회원가입 화면 및 \"마이페이지\" 메뉴 등에 게시하거나 기타의 방법으로 회원에게 공지합니다.\n2. 회사는 필요하다고 인정되는 경우, 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\n3. 회사는 약관을 개정할 경우, 적용 일자 및 개정 사유를 명시하여 현행약관과 함께 개정약관 적용 일자 7일 전부터 \"공지사항\"을 통해 공지합니다. 다만, 개정 내용이 회원의 권리 및 의무에 중대한 영향을 미치는 경우에는 적용 일자 30일 전부터 회원의 연락처 또는 서비스 내부 알림 수단으로 개별 공지합니다.\n4. 회원은 개정 약관에 동의하지 않을 경우, 제7조(서비스 이용계약의 종료)에 따른 회원 탈퇴 방법으로 거부 의사를 표시할 수 있습니다. 단, 회사가 약관 개정 시 \"개정 약관의 적용 일자까지 회원이 거부 의사를 표시하지 아니할 경우 약관의 개정에 동의한 것으로 간주한다\"는 내용을 고지하였음에도 불구하고 회원이 약관 개정에 대한 거부 의사를 표시하지 아니하면, 회사는 적용 일자부로 개정 약관에 동의한 것으로 간주합니다.\n5. 회원은 약관 일부분만을 동의 또는 거부할 수 없습니다.\n6. 회사는 제1항부터 제4항까지를 준수하였음에도 불구하고 회원이 약관 개정 사실을 알지 못함으로써 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제4조(서비스의 제공)\n1. 회사는 다음 서비스를 제공합니다.\n1.1. 정보 공유 커뮤니티 서비스 \n1.2. 중고 물품 거래 및 나눔 커뮤니티 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)1.3. 중고 거래를 위한 채팅 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)\n1.4.기타 회사가 정하는 서비스\n\n2. 회사는 운영상, 기술상의 필요에 따라 제공하고 있는 서비스를 변경할 수 있습니다.\n3. 회사는 이용자의 개인정보 및 서비스 이용 기록에 따라 서비스 이용에 차이를 둘 수 있습니다.\n4. 회사는 설비의 보수, 교체, 점검 또는 기간통신사업자의 서비스 중지, 인터넷 장애 등의 사유로 인해 일시적으로 서비스 제공이 어려울 경우, 통보 없이 일시적으로 서비스 제공을 중단할 수 있습니다.\n5. 회사는 천재지변, 전쟁, 경영 악화 등 불가항력적인 사유로 인해 서비스를 더 이상 제공하기 어려울 경우, 통보 없이 서비스 제공을 영구적으로 중단할 수 있습니다.\n6. 회사는 제3항부터 제5항까지 및 다음 내용으로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n6.1. 모든 서비스, 게시물, 이용 기록의 진본성, 무결성, 신뢰성, 이용가능성의 보장\n6.2. 서비스 이용 중 타인과 상호 간에 합의한 내용\n6.3. 게시물, 사용자가 첨부한 링크 등 외부로 연결된 서비스와 같이 회사가 제공하지 않은 서비스에서 발생한 피해\n6.4. 회사가 관련 법령에 따라 요구되는 보호조치를 이행하였음에도 불구하고, 네트워크의 안정성을 해치는 행위 또는 악성 프로그램 등에 의하여 발생하는 예기치 못한 이용자의 피해\n6.5. 이용자의 귀책 사유 또는 회사의 귀책 사유가 아닌 사유로 발생한 이용자의 피해\n\n제5조(서비스 이용계약의 성립)\n1. 회사와 회원의 서비스 이용계약은 서비스를 이용하고자 하는 자(이하 \"가입 신청자\"라고 합니다)가 서비스 내부의 회원가입 양식에 따라 필요한 회원정보를 기입하고, 이 약관, 개인정보 수집 및 이용 동의 등에 명시적인 동의를 한 후, 신청한 회원가입 의사 표시(이하 \"이용신청\"이라 합니다)를 회사가 승낙함으로써 체결됩니다.\n2. 제1항의 승낙은 신청순서에 따라 순차적으로 처리되며, 회원가입의 성립 시기는 회사의 회원가입이 완료되었음을 알리는 승낙의 통지가 회원에게 도달하거나, 이에 준하는 권한이 회원에게 부여되는 시점으로 합니다.\n3. 회사는 만 15세 미만 이용자의 이용신청을 금지하고 있습니다. 가입 신청자는 이용신청 시 만 15세 이상에 해당한다는 항목에 명시적인 동의를 함으로써 회원은 만 15세 이상임을 진술하고 보증합니다.\n4. 회사는 부정사용방지 및 본인확인을 위해 회원에게 본인 인증을 요청할 수 있습니다.\n5. 회사는 가입 신청자의 이용신청에 있어 다음 각 호에 해당하는 경우, 이용신청을 영구적으로 승낙하지 않거나 유보할 수 있습니다.\n5.1. 회사가 정한 이용신청 요건에 충족되지 않을 경우\n5.2. 가입 신청자가 만 15세 미만인 경우<\n5.3. 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우<\n5.4. 회사의 기술 및 설비 상 서비스를 제공할 수 없는 경우\n5.5. 기타 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우\n\n회사는 제3항부터 제5항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제6조(개인정보의 관리 및 보호)\n 1. 회사는 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 이용에 관해서는 관련 법령 및 회사의 개인정보 처리방침을 따릅니다.\n 2. 회원은 가입 시 개인정보에 기입한 이후 변동할 수 없기에 가입 시 신중하게 개인정보를 입력해야 합니다.\n 3. 회원의 아이디, 비밀번호 등 모든 개인정보의 관리책임은 본인에게 있으므로, 타인에게 양도 및 대여할 수 없으며 유출되지 않도록 관리해야 합니다. 만약 본인의 아이디 및 비밀번호를 타인이 사용하고 있음을 인지했을 경우, 즉시 문의 창구로 알려야 하고, 안내가 있는 경우 이에 따라야 합니다.\n 4. 회사는 회원이 제2항과 제3항을 이행하지 않아 발생한 피해에 대해, 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다. \n\n제7조(서비스 이용계약의 종료)\n 1. 회원은 언제든지 본인의 계정으로 로그인한 뒤 서비스 내부의 문의창구를 통해 탈퇴를 요청할 수 있습니다. 회사는 해당 요청을 확인한 후 탈퇴를 처리합니다.\n 2. 회원은 탈퇴 처리가 완료 되었더라도, 회원이 게시한 게시물은 삭제되지 않습니다.\n 3. 회사는 회원이 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우, 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n 4. 회사는 제1항부터 제4항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제8조(회원에 대한 통지)\n 1. 회사가 회원에 대한 통지가 필요한 경우, 회원의 연락처 또는 서비스 내부 알림 수단을 이용할 수 있습니다.\n 3. 회사는 회원 전체에 대한 통지의 경우 공지사항에 게시함으로써 전 항의 통지에 갈음할 수 있습니다. 단, 회원의 권리 및 의무에 중대한 영향을 미치는 사항에 대해서는 1항에 따릅니다.\n 4. 회사가 회원에게 ‘30일 이내에 의사를 표시하지 아니할 경우 동의한 것으로 간주한다’는 내용을 고지하였음에도 불구하고 회원이 의사를 표시하지 아니하면, 회사는 통지 내용에 동의한 것으로 간주합니다.\n\n제9조(저작권의 귀속)\n 1. 회사는 유용하고 편리한 서비스를 제공하기 위해, 2023년부터 서비스 및 서비스 내부의 기능을 직접 설계 및 운영하고 있는 데이터베이스 제작자에 해당합니다. 회사는 저작권법에 따라 데이터베이스 제작자는 복제권 및 전송권을 포함한 데이터베이스 전부에 대한 권리를 가지고 있으며, 이는 법률에 따라 보호를 받는 대상입니다. 그러므로 이용자는 데이터베이스 제작자인 회사의 승인 없이 데이터베이스의 전부 또는 일부를 복제·배포·방송 또는 전송할 수 없습니다.\n 2. 회사가 작성한 게시물에 대한 권리는 회사에 귀속되며, 회원이 작성한 게시물에 대한 권리는 회원에게 귀속됩니다.\n 3. 회원이 서비스에 게시물을 작성하는 경우 해당 게시물은 서비스에 노출될 수 있고 필요한 범위 내에서 사용, 저장, 복제, 수정, 공중송신, 전시, 배포 등의 방식으로 해당 게시물을 이용할 수 있도록 허락하는 전 세계적인 라이선스를 회사에 제공하게 됩니다. 이 경우, 회사는 저작권법을 준수하며 회원은 언제든지 문의 창구 및 서비스 내부의 관리 기능이 제공되는 경우에는 해당 관리 기능을 이용하여 가능한 범위에 한해 해당 게시물에 대한 삭제, 수정, 비공개 등의 조치를 취할 수 있습니다.\n 4. 회사는 제3항 이외의 방법으로 회원의 게시물을 이용할 경우, 해당 회원으로부터 개별적이고 명시적인 동의를 받아야 합니다.\n\n제10조(게시물의 삭제 및 접근 차단)\n 1. 누구든지 게시물로 인해 사생활 침해나 명예훼손 등 권리가 침해된 경우 회사에 해당 게시물의 삭제 또는 반박내용의 게재를 요청할 수 있습니다. 이 때 회사는 해당 게시물을 삭제할 수 있습니다.\n 2. 회사가 제1항에 따라 회원의 게시물을 삭제하거나 접근을 임시적으로 차단하는 경우, 해당 게시물이 작성된 커뮤니티에 필요한 조치를 한 사실을 명시하고, 불가능한 사유가 없을 경우 이를 요청한 자와 해당 게시물을 작성한 회원에게 그 사실을 통지합니다.\n\n제11조(금지행위)\n 1. 이용자는 다음과 같은 행위를 해서는 안됩니다. \n - 성적 도의관념에 반하는 행위 (정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따른 유해정보 유통 행위, 전기통신사업법에 따른 불법촬영물등 유통 행위, 청소년보호법에 따른 청소년유해매체물 유통 행위, 방송통신심의위원회의 정보통신에 관한 심의규정에 따른 심의기준의 성적 도의관념에 반하는 행위, 커뮤니티 이용규칙 금지행위에 따른 불건전 만남, 유흥, 성매매 등 내용 유통 행위)\n - 홍보/판매 행위(이 약관이 적용되는 서비스 및 기능과 동일하거나 유사한 서비스 및 기능에 대한 직·간접적 홍보 행위, 비상업적 목적의 일상 생활과 관련된 중고 품목 이외의 품목 등 커뮤니티 이용규칙 금지행위에 따른 홍보 및 판매 행위), \n - 개인정보 또는 계정 기만, 침해, 공유 행위(개인정보를 허위, 누락, 오기, 도용하여 작성하는 행위, 타인의 개인정보 및 계정을 수집, 저장, 공개, 이용하는 행위, 자신과 타인의 개인정보를 제3자에게 공개, 양도, 승계하는 행위, 다중 계정을 생성 및 이용하는 행위, 자신의 계정을 이용하여 타인의 요청을 이행하는 행위)\n - 시스템 부정행위(프로그램, 스크립트, 봇을 이용한 서비스 접근 등 사람이 아닌 컴퓨팅 시스템을 통한 서비스 접근 행위, API 직접 호출, 유저 에이전트 조작, 패킷 캡처, 비정상적인 반복 조회 및 요청 등 허가하지 않은 방식의 서비스 이용 행위, 회사의 모든 재산에 대한 침해 행위)\n - 업무 방해 행위(서비스 관리자 또는 이에 준하는 자격을 허가 없이 취득하여 권한을 행사하거나, 사칭하여 허위의 정보를 발설하는 행위, 회사 및 타인의 명예를 훼손하거나 기타 업무를 방해하는 행위, 서비스 내부 정보 일체를 허가 없이 이용, 변조, 삭제 및 외부로 유출하는 행위)\n - 기타 현행법에 어긋나거나 부적절하다고 판단되는 행위\n 2. 이용자는 제1항에 기재된 내용 외에 이 약관과 커뮤니티 이용규칙에서 규정한 내용에 반하는 행위를 해서는 안됩니다.\n 3. 이용자가 제1항에 해당하는 행위를 할 경우, 회사는 이 약관 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n\n제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)\n 1. 이용자가 이 약관 및 커뮤니티 이용규칙에서 이 조항 적용이 명시된 금지행위 및 이에 준하는 행위를 할 경우, 회사는 서비스 보호를 위해 다음과 같은 조치를 최대 영구적으로 취할 수 있습니다. (회원의 서비스 이용 권한, 자격, 혜택 제한 및 회수, 회원과 체결된 이용계약의 해지, 회원가입, 본인 인증, 회원의 커뮤니티, 게시물, 닉네임, 이용 기록을 삭제, 중단, 수정, 변경, 그 외 서비스의 정상적인 운영을 위해 회사가 필요하다고 판단되는 조치)\n 2. 회사는 서비스 제공 중단 및 서비스 이용계약 해지 시, 회원의 연락처 또는 서비스 내부 알림 수단을 통하여 그 사실을 사유와 함께 개별 통지합니다. 회원은 해당 통지를 받은 날로부터 7일 이내에 문의 창구로 이의를 제기할 수 있습니다.\n 3. 회사는 이용자의 귀책 사유로 인한 서비스 제공 중단 및 서비스 이용계약의 해지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제13조(재판권 및 준거법)\n 1. 회사와 이용자 간에 발생한 분쟁에 관한 소송은 민사소송법상의 관할 법원에 제소합니다.\n 2. 회사와 이용자 간에 제기된 소송에는 대한민국 법을 준거법으로 합니다.\n\n제14조(기타)\n\n 1. 이 약관은 2023년 1월 12일에 개정되었습니다.\n 2. 이 약관에도 불구하고, 회사와 이용자가 이 약관의 내용과 다르게 합의한 사항이 있는 경우에는 해당 내용을 우선으로 합니다. \n 3. 회사는 필요한 경우 약관의 하위 규정을 정할 수 있으며, 이 약관과 하위 규정이 상충하는 경우에는 이 약관의 내용이 우선 적용됩니다.\n 4. 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관련법 또는 관례에 따릅니다.",
};

Map<String, String> personalData = {
  'policyName': '개인정보처리방침',
  'policyContent':
      "< 곁으로 >('https://www.instagram.com/gyeoteuro/'이하 '곁으로')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.\n○ 이 개인정보처리방침은 2023년 1월 1부터 적용됩니다.\n제1조(개인정보의 처리 목적)\n< 곁으로 >('https://www.instagram.com/gyeoteuro/'이하 '곁으로')은(는) 다음의 목적을 위하여 개인정보를 처리합니다.\n처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.\n1. 홈페이지 회원가입 및 관리 회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지, 만14세 미만 아동의 개인정보 처리 시 법정대리인의 동의여부 확인, 각종 고지·통지, 고충처리 목적으로 개인정보를 처리합니다.\n2. 민원사무 처리 민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 목적으로 개인정보를 처리합니다.\n3. 재화 또는 서비스 제공 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증을 목적으로 개인정보를 처리합니다.\n4. 마케팅 및 광고에의 활용 인구통계학적 특성에 따른 서비스 제공 및 광고 게재 , 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.\n제2조(개인정보의 처리 및 보유 기간)\n① < 곁으로 >은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.\n② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.\n1.<홈페이지 회원가입 및 관리>\n<홈페이지 회원가입 및 관리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<3년>까지 위 이용목적을 위하여 보유.이용됩니다.\n보유근거 : 사용자의 신원 확인, 중복된 사용자 가입 방지 관련법령 : 신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년 예외사유 :\n제3조(처리하는 개인정보의 항목)\n① < 곁으로 >은(는) 다음의 개인정보 항목을 처리하고 있습니다.\n1< 홈페이지 회원가입 및 관리 > 필수항목 : 이메일, 휴대전화번호, 비밀번호, 로그인ID, 성별, 생년월일, 이름, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보 선택항목 :\n제4조(개인정보의 제3자 제공에 관한 사항)\n① < 곁으로 >은(는) 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 「개인정보 보호법」 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.\n② < 곁으로 >은(는) 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.\n1. < > 개인정보를 제공받는 자 : 제공받는 자의 개인정보 이용목적 : 제공받는 자의 보유.이용기간:\n제5조(개인정보처리의 위탁에 관한 사항)\n① < 곁으로 >은(는) 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.\n1. < > 위탁받는 자 (수탁자) : 위탁하는 업무의 내용 : 위탁기간 :\n② < 곁으로 >은(는) 위탁계약 체결시 「개인정보 보호법」 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.\n③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.\n제6조(개인정보의 파기절차 및 파기방법)\n① < 곁으로 > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.\n② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.\n1. 법령 근거 :\n2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜\n③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.\n1. 파기절차 < 곁으로 > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < 곁으로 > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.\n2. 파기방법 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.\n제7조(미이용자의 개인정보 파기 등에 관한 조치)\n① <개인정보처리자명>은(는) 1년간 서비스를 이용하지 않은 이용자는 휴면계정으로 전환하고, 개인정보를 별도로 분리하여 보관합니다. 분리 보관된 개인정보는 1년간 보관 후 지체없이 파기합니다.\n② <개인정보처리자명>은(는) 휴먼전환 30일 전까지 휴면예정 회원에게 별도 분리 보관되는 사실 및 휴면 예정일, 별도 분리 보관하는 개인정보 항목을 이메일, 문자 등 이용자에게 통지 가능한 방법으로 알리고 있습니다.\n③ 휴면계정으로 전환을 원하지 않으시는 경우, 휴면계정 전환 전 서비스 로그인을 하시면 됩니다. 또한, 휴면계정으로 전환되었더라도 로그인을 하는 경우 이용자의 동의에 따라 휴면계정을 복원하여 정상적인 서비스를 이용할 수 있습니다.\n제8조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)\n① 정보주체는 곁으로에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.\n② 제1항에 따른 권리 행사는곁으로에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 곁으로은(는) 이에 대해 지체 없이 조치하겠습니다.\n③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.\n④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.\n⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.\n⑥ 곁으로은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.\n제9조(개인정보의 안전성 확보조치에 관한 사항)\n< 곁으로 >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n1. 정기적인 자체 감사 실시 개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.\n2. 개인정보 취급 직원의 최소화 및 교육 개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.\n3. 내부관리계획의 수립 및 시행 개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.\n4. 문서보안을 위한 잠금장치 사용 개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다.\n5. 비인가자에 대한 출입 통제 개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.\n제10조(개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항)\n① 곁으로 은(는) 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.\n② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.\n가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.\n나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.\n다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.\n제11조(행태정보의 수집·이용·제공 및 거부 등에 관한 사항)\n① <개인정보처리자>은(는) 서비스 이용과정에서 정보주체에게 최적화된 맞춤형 서비스 및 혜택, 온라인 맞춤형 광고 등을 제공하기 위하여 행태정보를 수집·이용하고 있습니다.\n② <개인정보처리자>은(는) 다음과 같이 행태정보를 수집합니다.\n11. 행태정보의 수집·이용·제공 및 거부 등에 관한 사항 제공을 위해 수집하는 행태정보의 항목, 행태정보 수집 방법, 행태정보 수집 목적, 보유·이용기간 및 이후 정보처리 방법을 입력하기 위한 표입니다. 수집하는 행태정보의 항목 행태정보 수집 방법 행태정보 수집 목적 보유·이용기간 및 이후 정보처리 방법 앱 서비스 방문이력 앱 실행시 자동수집 이용자의 행태에 기반한 맞춤 서비스 제공 수집일로부터 3년 후 파기 <온라인 맞춤형 광고 등을 위해 제3자(온라인 광고사업자 등)가 이용자의 행태정보를 수집·처리할수 있도록 허용한 경우>\n③ <개인정보처리자>은(는) 다음과 같이 온라인 맞춤형 광고 사업자가 행태정보를 수집·처리하도록 허용하고 있습니다. - 행태정보 수집 방법 : 이용자가 당사 웹사이트를 방문하거나 앱을 실행할 때 자동 수집 및 전송 - 수집·처리되는 행태정보 항목 : 이용자의 웹/앱 방문이력, 검색이력, 구매이력 - 보유·이용기간 : 00일\n④ <개인정보처리자>은(는) 온라인 맞춤형 광고 등에 필요한 최소한의 행태정보만을 수집하며, 사상, 신념, 가족 및 친인척관계, 학력·병력, 기타 사회활동 경력 등 개인의 권리·이익이나 사생활을 뚜렷하게 침해할 우려가 있는 민감한 행태정보를 수집하지 않습니다.\n⑤ <개인정보처리자>은(는) 만 14세 미만임을 알고 있는 아동이나 만14세 미만의 아동을 주 이용자로 하는 온라인 서비스로부터 맞춤형 광고 목적의 행태정보를 수집하지 않고, 만 14세 미만임을 알고 있는 아동에게는 맞춤형 광고를 제공하지 않습니다.\n⑥ <개인정보처리자>은(는) 모바일 앱에서 온라인 맞춤형 광고를 위하여 광고식별자를 수집·이용합니다. 정보주체는 모바일 단말기의 설정 변경을 통해 앱의 맞춤형 광고를 차단·허용할 수 있습니다. ‣ 스마트폰의 광고식별자 차단/허용\n(1) (안드로이드) ① 설정 → ② 개인정보보호 → ③ 광고 → ④ 광고 ID 재설정 또는 광고ID 삭제\n(2) (아이폰) ① 설정 → ② 개인정보보호 → ③ 추적 → ④ 앱이 추적을 요청하도록 허용 끔\n※ 모바일 OS 버전에 따라 메뉴 및 방법이 다소 상이할 수 있습니다.\n⑦ 정보주체는 웹브라우저의 쿠키 설정 변경 등을 통해 온라인 맞춤형 광고를 일괄적으로 차단·허용할 수 있습니다. 다만, 쿠키 설정 변경은 웹사이트 자동로그인 등 일부 서비스의 이용에 영향을 미칠 수 있습니다.\n‣ 웹브라우저를 통한 맞춤형 광고 차단/허용\n(1) 인터넷 익스플로러(Windows 10용 Internet Explorer 11) - Internet Explorer에서 도구 버튼을 선택한 다음 인터넷 옵션을 선택 - 개인 정보 탭을 선택하고 설정에서 고급을 선택한 다음 쿠키의 차단 또는 허용을 선택 (2) Microsoft Edge - Edge에서 오른쪽 상단 ‘…’ 표시를 클릭한 후, 설정을 클릭합니다. - 설정 페이지 좌측의 ‘개인정보, 검색 및 서비스’를 클릭 후 「추적방지」 섹션에서 ‘추적방지’ 여부 및 수준을 선택합니다. - ‘InPrivate를 검색할 때 항상 \"\"엄격\"\" 추적 방지 사용’ 여부를 선택합니다. - 아래 「개인정보」 섹션에서 ‘추적 안함 요청보내기’ 여부를 선택합니다. (3) 크롬 브라우저 - Chrome에서 오른쪽 상단 ‘⋮’ 표시(chrome 맞춤설정 및 제어)를 클릭한 후, 설정 표시를 클릭합니다. - 설정 페이지 하단에 ‘고급 설정 표시’를 클릭하고 「개인정보」 섹션에서 콘텐츠 설정을 클릭합니다. - 쿠키 섹션에서 ‘타사 쿠키 및 사이트 데이터 차단’의 체크박스를 선택합니다. 52 | 개인정보 처리방침 작성지침 일반 ⑧ 정보주체는 아래의 연락처로 행태정보와 관련하여 궁금한 사항과 거부권 행사, 피해 신고 접수 등을 문의할 수 있습니다. ‣ 개인정보 보호 담당부서 부서명 : 보안 팀 담당자 : 윤하은 연락처 : 01090167850, qlxqlrt2012@gmail.com, 제12조(추가적인 이용·제공 판단기준) < 곁으로 > 은(는) ｢개인정보 보호법｣ 제15조제3항 및 제17조제4항에 따라 ｢개인정보 보호법 시행령｣ 제14조의2에 따른 사항을 고려하여 정보주체의 동의 없이 개인정보를 추가적으로 이용·제공할 수 있습니다. 이에 따라 < 곁으로 > 가(이) 정보주체의 동의 없이 추가적인 이용·제공을 하기 위해서 다음과 같은 사항을 고려하였습니다. ▶ 개인정보를 추가적으로 이용·제공하려는 목적이 당초 수집 목적과 관련성이 있는지 여부 ▶ 개인정보를 수집한 정황 또는 처리 관행에 비추어 볼 때 추가적인 이용·제공에 대한 예측 가능성이 있는지 여부 ▶ 개인정보의 추가적인 이용·제공이 정보주체의 이익을 부당하게 침해하는지 여부 ▶ 가명처리 또는 암호화 등 안전성 확보에 필요한 조치를 하였는지 여부 ※ 추가적인 이용·제공 시 고려사항에 대한 판단기준은 사업자/단체 스스로 자율적으로 판단하여 작성·공개함 제13조(가명정보를 처리하는 경우 가명정보 처리에 관한 사항) < 곁으로 > 은(는) 다음과 같은 목적으로 가명정보를 처리하고 있습니다. ▶ 가명정보의 처리 목적 - 직접작성 가능합니다. ▶ 가명정보의 처리 및 보유기간 - 직접작성 가능합니다. ▶ 가명정보의 제3자 제공에 관한 사항(해당되는 경우에만 작성) - 직접작성 가능합니다. ▶ 가명정보 처리의 위탁에 관한 사항 ▶ 가명처리하는 개인정보의 항목  ▶ 법 제28조의4(가명정보에 대한 안전조치 의무 등)에 따른 가명정보의 안전성 확보조치에 관한 사항 - 직접작성 가능합니다. 제14조 (개인정보 보호책임자에 관한 사항) ① 곁으로 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다. ▶ 개인정보 보호책임자 성명 :윤하은 직책 :팀원 직급 :팀원 연락처 :01090167850, qlxqlrt2012@gmail.com, ※ 개인정보 보호 담당부서로 연결됩니다. ▶ 개인정보 보호 담당부서 부서명 :보안팀 담당자 :윤하은 연락처 :01090167850, qlxqlrt2012@gmail.com, ② 정보주체께서는 곁으로 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 곁으로 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다. 제15조(국내대리인의 지정) 정보주체는 ｢개인정보 보호법｣ 제39조의11에 따라 지정된 < 곁으로 >의 국내대리인에게 개인정보 관련 고충처리 등의 업무를 위하여 연락을 취할 수 있습니다. < 곁으로 >은(는) 정보주체의 개인정보 관련 고충처리 등 개인정보 보호책임자의 업무 등을 신속하게 처리할 수 있도록 노력하겠습니다. 제16조(개인정보의 열람청구를 접수·처리하는 부서) 정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. < 곁으로 >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다. ▶ 개인정보 열람청구 접수·처리 부서 부서명 : 보안팀 담당자 : 윤하은 연락처 : 01090167850, qlxqlrt2012@gmail.com, 제17조(정보주체의 권익침해에 대한 구제방법) 정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다. 1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr) 2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr) 3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr) 4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr) 「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다. ※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다. 제18조(영상정보처리기기 운영·관리에 관한 사항) ① < 곁으로 >은(는) 아래와 같이 영상정보처리기기를 설치·운영하고 있습니다. 1.영상정보처리기기 설치근거·목적 : < 곁으로 >의 2.설치 대수, 설치 위치, 촬영 범위 : 설치대수 : 대 설치위치 : 촬영범위 : 3.관리책임자, 담당부서 및 영상정보에 대한 접근권한자 : 4.영상정보 촬영시간, 보관기간, 보관장소, 처리방법 촬영시간 : 시간 보관기간 : 촬영시부터 보관장소 및 처리방법\n5.영상정보 확인 방법 및 장소\n6.정보주체의 영상정보 열람 등 요구에 대한 조치 : 개인영상정보 열람.존재확인 청구서로 신청하여야 하며, 정보주체 자신이 촬영된 경우 또는 명백히 정보주체의 생명.신체.재산 이익을 위해 필요한 경우에 한해 열람을 허용함\n7.영상정보 보호를 위한 기술적.관리적.물리적 조치\n제19조(개인정보 처리방침 변경)\n① 이 개인정보처리방침은 2023년 1월 1부터 적용됩니다.\n2023. 1. 1 ~ 2026. 1. 1 적용 ",
};
