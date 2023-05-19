// ignore_for_file: deprecated_member_use

import 'package:byourside/main.dart';
import 'package:flutter/material.dart';

class UsingPolicy extends StatefulWidget {
  const UsingPolicy({Key? key}) : super(key: key);

  @override
  State<UsingPolicy> createState() => _UsingPolicyState();
}

class _UsingPolicyState extends State<UsingPolicy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("이용 약관",
              semanticsLabel: "이용 약관",
              style: TextStyle(
                  fontFamily: 'NanumGothic', fontWeight: FontWeight.bold)),
          backgroundColor: primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  semanticLabel: "뒤로 가기", color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            scrollDirection: Axis.vertical,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "곁 서비스 이용 약관",
                    semanticsLabel: "곁 서비스 이용 약관",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NanumGothic',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            "< 곁으로 >('https://www.instagram.com/gyeoteuro/'이하 '곁으로')은(는) 사용자의 신속하고 원활한 서비스 이용을 위하여 다음과 같이 서비스 이용약관을 수립·공개합니다.\n\n제1조(목적) \n곁 서비스 이용약관은 곁으로(이하 \"회사\"라 합니다)가 제공하는 곁 서비스의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임 사항 등을 규정함을 목적으로 합니다.\n\n 제2조(정의)\n이 약관에서 사용하는 용어의 정의는 다음과 같습니다. \n1.\"서비스\"란, 회사가 제공하는 모든 서비스 및 기능을 말합니다.\n2.\"이용자\"란, 이 약관에 따라 서비스를 이용하는 회원을 말합니다.\n3.\"회원\"이란, 서비스에 회원등록을 하고 서비스를 이용하는 자를 말합니다.\n4.\"게시물\"이란, 서비스에 게재된 사진 등을 말합니다.\n5.\"커뮤니티\"란, 게시물을 게시할 수 있는 공간을 말합니다.\n6.\"이용 기록\"이란, 이용자가 서비스를 이용하면서 직접 생성한 글 및 댓글, 채팅방 및 대화 등을 말합니다.\n7.\"로그 기록\"이란, 이용자가 서비스를 이용하면서 자동으로 생성된 IP 주소, 접속 시간 등을 말합니다.\n8.\"기기 정보\"란, 이용자의 통신 기기에서 수집된 유저 에이전트, ADID 등을 말합니다.\n9.\"계정\"이란, 이용계약을 통해 생성된 회원의 고유 아이디와 이에 수반하는 정보를 말합니다.\n10.\"서비스 내부 알림 수단\"이란, 알림, 1:1 대화, 내 정보 메뉴 등을 말합니다.\n11.\"연락처\"란, 회원가입, 본인 인증, 문의 창구 등을 통해 수집된 이용자의 이메일, 휴대전화 번호 등을 의미합니다.\n12.\"관련법\"이란, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신사업법, 개인정보보호법 등 관련 있는 국내 법령을 말합니다.\n13.\"본인 인증\"이란, 휴대전화 번호 등을 이용한 본인 확인 절차를 말합니다.\n제1항에서 정의되지 않은 이 약관 내 용어의 의미는 일반적인 이용관행에 의합니다.\n\n제3조(약관 등의 명시와 설명 및 개정)\n1. 회사는 이 약관을 회원가입 화면 및 \"마이페이지\" 메뉴 등에 게시하거나 기타의 방법으로 회원에게 공지합니다.\n2. 회사는 필요하다고 인정되는 경우, 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\n3. 회사는 약관을 개정할 경우, 적용 일자 및 개정 사유를 명시하여 현행약관과 함께 개정약관 적용 일자 7일 전부터 \"공지사항\"을 통해 공지합니다. 다만, 개정 내용이 회원의 권리 및 의무에 중대한 영향을 미치는 경우에는 적용 일자 30일 전부터 회원의 연락처 또는 서비스 내부 알림 수단으로 개별 공지합니다.\n4. 회원은 개정 약관에 동의하지 않을 경우, 제7조(서비스 이용계약의 종료)에 따른 회원 탈퇴 방법으로 거부 의사를 표시할 수 있습니다. 단, 회사가 약관 개정 시 \"개정 약관의 적용 일자까지 회원이 거부 의사를 표시하지 아니할 경우 약관의 개정에 동의한 것으로 간주한다\"는 내용을 고지하였음에도 불구하고 회원이 약관 개정에 대한 거부 의사를 표시하지 아니하면, 회사는 적용 일자부로 개정 약관에 동의한 것으로 간주합니다.\n5. 회원은 약관 일부분만을 동의 또는 거부할 수 없습니다.\n6. 회사는 제1항부터 제4항까지를 준수하였음에도 불구하고 회원이 약관 개정 사실을 알지 못함으로써 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제4조(서비스의 제공)\n1. 회사는 다음 서비스를 제공합니다.\n1.1. 정보 공유 커뮤니티 서비스 \n1.2. 중고 물품 거래 및 나눔 커뮤니티 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)\1.3. 중고 거래를 위한 채팅 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)\n1.4.기타 회사가 정하는 서비스\n\n2. 회사는 운영상, 기술상의 필요에 따라 제공하고 있는 서비스를 변경할 수 있습니다.\n3. 회사는 이용자의 개인정보 및 서비스 이용 기록에 따라 서비스 이용에 차이를 둘 수 있습니다.\n4. 회사는 설비의 보수, 교체, 점검 또는 기간통신사업자의 서비스 중지, 인터넷 장애 등의 사유로 인해 일시적으로 서비스 제공이 어려울 경우, 통보 없이 일시적으로 서비스 제공을 중단할 수 있습니다.\n5. 회사는 천재지변, 전쟁, 경영 악화 등 불가항력적인 사유로 인해 서비스를 더 이상 제공하기 어려울 경우, 통보 없이 서비스 제공을 영구적으로 중단할 수 있습니다.\n6. 회사는 제3항부터 제5항까지 및 다음 내용으로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n6.1. 모든 서비스, 게시물, 이용 기록의 진본성, 무결성, 신뢰성, 이용가능성의 보장\n6.2. 서비스 이용 중 타인과 상호 간에 합의한 내용\n6.3. 게시물, 사용자가 첨부한 링크 등 외부로 연결된 서비스와 같이 회사가 제공하지 않은 서비스에서 발생한 피해\n6.4. 회사가 관련 법령에 따라 요구되는 보호조치를 이행하였음에도 불구하고, 네트워크의 안정성을 해치는 행위 또는 악성 프로그램 등에 의하여 발생하는 예기치 못한 이용자의 피해\n6.5. 이용자의 귀책 사유 또는 회사의 귀책 사유가 아닌 사유로 발생한 이용자의 피해\n\n제5조(서비스 이용계약의 성립)\n1. 회사와 회원의 서비스 이용계약은 서비스를 이용하고자 하는 자(이하 \"가입 신청자\"라고 합니다)가 서비스 내부의 회원가입 양식에 따라 필요한 회원정보를 기입하고, 이 약관, 개인정보 수집 및 이용 동의 등에 명시적인 동의를 한 후, 신청한 회원가입 의사 표시(이하 \"이용신청\"이라 합니다)를 회사가 승낙함으로써 체결됩니다.\n2. 제1항의 승낙은 신청순서에 따라 순차적으로 처리되며, 회원가입의 성립 시기는 회사의 회원가입이 완료되었음을 알리는 승낙의 통지가 회원에게 도달하거나, 이에 준하는 권한이 회원에게 부여되는 시점으로 합니다.\n3. 회사는 만 15세 미만 이용자의 이용신청을 금지하고 있습니다. 가입 신청자는 이용신청 시 만 15세 이상에 해당한다는 항목에 명시적인 동의를 함으로써 회원은 만 15세 이상임을 진술하고 보증합니다.\n4. 회사는 부정사용방지 및 본인확인을 위해 회원에게 본인 인증을 요청할 수 있습니다.\n5. 회사는 가입 신청자의 이용신청에 있어 다음 각 호에 해당하는 경우, 이용신청을 영구적으로 승낙하지 않거나 유보할 수 있습니다.\n5.1. 회사가 정한 이용신청 요건에 충족되지 않을 경우\n5.2. 가입 신청자가 만 15세 미만인 경우<\n5.3. 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우<\n5.4. 회사의 기술 및 설비 상 서비스를 제공할 수 없는 경우\n5.5. 기타 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우\n\n회사는 제3항부터 제5항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제6조(개인정보의 관리 및 보호)\n 1. 회사는 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 이용에 관해서는 관련 법령 및 회사의 개인정보 처리방침을 따릅니다.\n 2. 회원은 가입 시 개인정보에 기입한 이후 변동할 수 없기에 가입 시 신중하게 개인정보를 입력해야 합니다.\n 3. 회원의 아이디, 비밀번호 등 모든 개인정보의 관리책임은 본인에게 있으므로, 타인에게 양도 및 대여할 수 없으며 유출되지 않도록 관리해야 합니다. 만약 본인의 아이디 및 비밀번호를 타인이 사용하고 있음을 인지했을 경우, 즉시 문의 창구로 알려야 하고, 안내가 있는 경우 이에 따라야 합니다.\n 4. 회사는 회원이 제2항과 제3항을 이행하지 않아 발생한 피해에 대해, 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다. \n\n제7조(서비스 이용계약의 종료)\n 1. 회원은 언제든지 본인의 계정으로 로그인한 뒤 서비스 내부의 문의창구를 통해 탈퇴를 요청할 수 있습니다. 회사는 해당 요청을 확인한 후 탈퇴를 처리합니다.\n 2. 회원은 탈퇴 처리가 완료 되었더라도, 회원이 게시한 게시물은 삭제되지 않습니다.\n 3. 회사는 회원이 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우, 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n 4. 회사는 제1항부터 제4항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제8조(회원에 대한 통지)\n 1. 회사가 회원에 대한 통지가 필요한 경우, 회원의 연락처 또는 서비스 내부 알림 수단을 이용할 수 있습니다.\n 3. 회사는 회원 전체에 대한 통지의 경우 공지사항에 게시함으로써 전 항의 통지에 갈음할 수 있습니다. 단, 회원의 권리 및 의무에 중대한 영향을 미치는 사항에 대해서는 1항에 따릅니다.\n 4. 회사가 회원에게 ‘30일 이내에 의사를 표시하지 아니할 경우 동의한 것으로 간주한다’는 내용을 고지하였음에도 불구하고 회원이 의사를 표시하지 아니하면, 회사는 통지 내용에 동의한 것으로 간주합니다.\n\n제9조(저작권의 귀속)\n 1. 회사는 유용하고 편리한 서비스를 제공하기 위해, 2023년부터 서비스 및 서비스 내부의 기능을 직접 설계 및 운영하고 있는 데이터베이스 제작자에 해당합니다. 회사는 저작권법에 따라 데이터베이스 제작자는 복제권 및 전송권을 포함한 데이터베이스 전부에 대한 권리를 가지고 있으며, 이는 법률에 따라 보호를 받는 대상입니다. 그러므로 이용자는 데이터베이스 제작자인 회사의 승인 없이 데이터베이스의 전부 또는 일부를 복제·배포·방송 또는 전송할 수 없습니다.\n 2. 회사가 작성한 게시물에 대한 권리는 회사에 귀속되며, 회원이 작성한 게시물에 대한 권리는 회원에게 귀속됩니다.\n 3. 회원이 서비스에 게시물을 작성하는 경우 해당 게시물은 서비스에 노출될 수 있고 필요한 범위 내에서 사용, 저장, 복제, 수정, 공중송신, 전시, 배포 등의 방식으로 해당 게시물을 이용할 수 있도록 허락하는 전 세계적인 라이선스를 회사에 제공하게 됩니다. 이 경우, 회사는 저작권법을 준수하며 회원은 언제든지 문의 창구 및 서비스 내부의 관리 기능이 제공되는 경우에는 해당 관리 기능을 이용하여 가능한 범위에 한해 해당 게시물에 대한 삭제, 수정, 비공개 등의 조치를 취할 수 있습니다.\n 4. 회사는 제3항 이외의 방법으로 회원의 게시물을 이용할 경우, 해당 회원으로부터 개별적이고 명시적인 동의를 받아야 합니다.\n\n제10조(게시물의 삭제 및 접근 차단)\n 1. 누구든지 게시물로 인해 사생활 침해나 명예훼손 등 권리가 침해된 경우 회사에 해당 게시물의 삭제 또는 반박내용의 게재를 요청할 수 있습니다. 이 때 회사는 해당 게시물을 삭제할 수 있습니다.\n 2. 회사가 제1항에 따라 회원의 게시물을 삭제하거나 접근을 임시적으로 차단하는 경우, 해당 게시물이 작성된 커뮤니티에 필요한 조치를 한 사실을 명시하고, 불가능한 사유가 없을 경우 이를 요청한 자와 해당 게시물을 작성한 회원에게 그 사실을 통지합니다.\n\n제11조(금지행위)\n 1. 이용자는 다음과 같은 행위를 해서는 안됩니다. \n - 성적 도의관념에 반하는 행위 (정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따른 유해정보 유통 행위, 전기통신사업법에 따른 불법촬영물등 유통 행위, 청소년보호법에 따른 청소년유해매체물 유통 행위, 방송통신심의위원회의 정보통신에 관한 심의규정에 따른 심의기준의 성적 도의관념에 반하는 행위, 커뮤니티 이용규칙 금지행위에 따른 불건전 만남, 유흥, 성매매 등 내용 유통 행위)\n - 홍보/판매 행위(이 약관이 적용되는 서비스 및 기능과 동일하거나 유사한 서비스 및 기능에 대한 직·간접적 홍보 행위, 비상업적 목적의 일상 생활과 관련된 중고 품목 이외의 품목 등 커뮤니티 이용규칙 금지행위에 따른 홍보 및 판매 행위), \n - 개인정보 또는 계정 기만, 침해, 공유 행위(개인정보를 허위, 누락, 오기, 도용하여 작성하는 행위, 타인의 개인정보 및 계정을 수집, 저장, 공개, 이용하는 행위, 자신과 타인의 개인정보를 제3자에게 공개, 양도, 승계하는 행위, 다중 계정을 생성 및 이용하는 행위, 자신의 계정을 이용하여 타인의 요청을 이행하는 행위)\n - 시스템 부정행위(프로그램, 스크립트, 봇을 이용한 서비스 접근 등 사람이 아닌 컴퓨팅 시스템을 통한 서비스 접근 행위, API 직접 호출, 유저 에이전트 조작, 패킷 캡처, 비정상적인 반복 조회 및 요청 등 허가하지 않은 방식의 서비스 이용 행위, 회사의 모든 재산에 대한 침해 행위)\n - 업무 방해 행위(서비스 관리자 또는 이에 준하는 자격을 허가 없이 취득하여 권한을 행사하거나, 사칭하여 허위의 정보를 발설하는 행위, 회사 및 타인의 명예를 훼손하거나 기타 업무를 방해하는 행위, 서비스 내부 정보 일체를 허가 없이 이용, 변조, 삭제 및 외부로 유출하는 행위)\n - 기타 현행법에 어긋나거나 부적절하다고 판단되는 행위\n 2. 이용자는 제1항에 기재된 내용 외에 이 약관과 커뮤니티 이용규칙에서 규정한 내용에 반하는 행위를 해서는 안됩니다.\n 3. 이용자가 제1항에 해당하는 행위를 할 경우, 회사는 이 약관 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n\n제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)\n 1. 이용자가 이 약관 및 커뮤니티 이용규칙에서 이 조항 적용이 명시된 금지행위 및 이에 준하는 행위를 할 경우, 회사는 서비스 보호를 위해 다음과 같은 조치를 최대 영구적으로 취할 수 있습니다. (회원의 서비스 이용 권한, 자격, 혜택 제한 및 회수, 회원과 체결된 이용계약의 해지, 회원가입, 본인 인증, 회원의 커뮤니티, 게시물, 닉네임, 이용 기록을 삭제, 중단, 수정, 변경, 그 외 서비스의 정상적인 운영을 위해 회사가 필요하다고 판단되는 조치)\n 2. 회사는 서비스 제공 중단 및 서비스 이용계약 해지 시, 회원의 연락처 또는 서비스 내부 알림 수단을 통하여 그 사실을 사유와 함께 개별 통지합니다. 회원은 해당 통지를 받은 날로부터 7일 이내에 문의 창구로 이의를 제기할 수 있습니다.\n 3. 회사는 이용자의 귀책 사유로 인한 서비스 제공 중단 및 서비스 이용계약의 해지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제13조(재판권 및 준거법)\n 1. 회사와 이용자 간에 발생한 분쟁에 관한 소송은 민사소송법상의 관할 법원에 제소합니다.\n 2. 회사와 이용자 간에 제기된 소송에는 대한민국 법을 준거법으로 합니다.\n\n제15조(기타)\n\n 1. 이 약관은 2023년 1월 12일에 개정되었습니다.\n 2. 이 약관에도 불구하고, 회사와 이용자가 이 약관의 내용과 다르게 합의한 사항이 있는 경우에는 해당 내용을 우선으로 합니다. \n 3. 회사는 필요한 경우 약관의 하위 규정을 정할 수 있으며, 이 약관과 하위 규정이 상충하는 경우에는 이 약관의 내용이 우선 적용됩니다.\n 4. 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관련법 또는 관례에 따릅니다.",
                            semanticsLabel:
                                "< 곁으로 >('https://www.instagram.com/gyeoteuro/'이하 '곁으로')은(는) 사용자의 신속하고 원활한 서비스 이용을 위하여 다음과 같이 서비스 이용약관을 수립·공개합니다.\n\n제1조(목적) \n곁 서비스 이용약관은 곁으로(이하 \"회사\"라 합니다)가 제공하는 곁 서비스의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임 사항 등을 규정함을 목적으로 합니다.\n\n 제2조(정의)\n이 약관에서 사용하는 용어의 정의는 다음과 같습니다. \n1.\"서비스\"란, 회사가 제공하는 모든 서비스 및 기능을 말합니다.\n2.\"이용자\"란, 이 약관에 따라 서비스를 이용하는 회원을 말합니다.\n3.\"회원\"이란, 서비스에 회원등록을 하고 서비스를 이용하는 자를 말합니다.\n4.\"게시물\"이란, 서비스에 게재된 사진 등을 말합니다.\n5.\"커뮤니티\"란, 게시물을 게시할 수 있는 공간을 말합니다.\n6.\"이용 기록\"이란, 이용자가 서비스를 이용하면서 직접 생성한 글 및 댓글, 채팅방 및 대화 등을 말합니다.\n7.\"로그 기록\"이란, 이용자가 서비스를 이용하면서 자동으로 생성된 IP 주소, 접속 시간 등을 말합니다.\n8.\"기기 정보\"란, 이용자의 통신 기기에서 수집된 유저 에이전트, ADID 등을 말합니다.\n9.\"계정\"이란, 이용계약을 통해 생성된 회원의 고유 아이디와 이에 수반하는 정보를 말합니다.\n10.\"서비스 내부 알림 수단\"이란, 알림, 1:1 대화, 내 정보 메뉴 등을 말합니다.\n11.\"연락처\"란, 회원가입, 본인 인증, 문의 창구 등을 통해 수집된 이용자의 이메일, 휴대전화 번호 등을 의미합니다.\n12.\"관련법\"이란, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신사업법, 개인정보보호법 등 관련 있는 국내 법령을 말합니다.\n13.\"본인 인증\"이란, 휴대전화 번호 등을 이용한 본인 확인 절차를 말합니다.\n제1항에서 정의되지 않은 이 약관 내 용어의 의미는 일반적인 이용관행에 의합니다.\n\n제3조(약관 등의 명시와 설명 및 개정)\n1. 회사는 이 약관을 회원가입 화면 및 \"마이페이지\" 메뉴 등에 게시하거나 기타의 방법으로 회원에게 공지합니다.\n2. 회사는 필요하다고 인정되는 경우, 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\n3. 회사는 약관을 개정할 경우, 적용 일자 및 개정 사유를 명시하여 현행약관과 함께 개정약관 적용 일자 7일 전부터 \"공지사항\"을 통해 공지합니다. 다만, 개정 내용이 회원의 권리 및 의무에 중대한 영향을 미치는 경우에는 적용 일자 30일 전부터 회원의 연락처 또는 서비스 내부 알림 수단으로 개별 공지합니다.\n4. 회원은 개정 약관에 동의하지 않을 경우, 제7조(서비스 이용계약의 종료)에 따른 회원 탈퇴 방법으로 거부 의사를 표시할 수 있습니다. 단, 회사가 약관 개정 시 \"개정 약관의 적용 일자까지 회원이 거부 의사를 표시하지 아니할 경우 약관의 개정에 동의한 것으로 간주한다\"는 내용을 고지하였음에도 불구하고 회원이 약관 개정에 대한 거부 의사를 표시하지 아니하면, 회사는 적용 일자부로 개정 약관에 동의한 것으로 간주합니다.\n5. 회원은 약관 일부분만을 동의 또는 거부할 수 없습니다.\n6. 회사는 제1항부터 제4항까지를 준수하였음에도 불구하고 회원이 약관 개정 사실을 알지 못함으로써 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제4조(서비스의 제공)\n1. 회사는 다음 서비스를 제공합니다.\n1.1. 정보 공유 커뮤니티 서비스 \n1.2. 중고 물품 거래 및 나눔 커뮤니티 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)\1.3. 중고 거래를 위한 채팅 서비스\n(단, 본 서비스는 거래의 장을 제공할 뿐, 결제, 이체 등 어떠한 금전적인 서비스도 지원하지 않습니다.)\n1.4.기타 회사가 정하는 서비스\n\n2. 회사는 운영상, 기술상의 필요에 따라 제공하고 있는 서비스를 변경할 수 있습니다.\n3. 회사는 이용자의 개인정보 및 서비스 이용 기록에 따라 서비스 이용에 차이를 둘 수 있습니다.\n4. 회사는 설비의 보수, 교체, 점검 또는 기간통신사업자의 서비스 중지, 인터넷 장애 등의 사유로 인해 일시적으로 서비스 제공이 어려울 경우, 통보 없이 일시적으로 서비스 제공을 중단할 수 있습니다.\n5. 회사는 천재지변, 전쟁, 경영 악화 등 불가항력적인 사유로 인해 서비스를 더 이상 제공하기 어려울 경우, 통보 없이 서비스 제공을 영구적으로 중단할 수 있습니다.\n6. 회사는 제3항부터 제5항까지 및 다음 내용으로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n6.1. 모든 서비스, 게시물, 이용 기록의 진본성, 무결성, 신뢰성, 이용가능성의 보장\n6.2. 서비스 이용 중 타인과 상호 간에 합의한 내용\n6.3. 게시물, 사용자가 첨부한 링크 등 외부로 연결된 서비스와 같이 회사가 제공하지 않은 서비스에서 발생한 피해\n6.4. 회사가 관련 법령에 따라 요구되는 보호조치를 이행하였음에도 불구하고, 네트워크의 안정성을 해치는 행위 또는 악성 프로그램 등에 의하여 발생하는 예기치 못한 이용자의 피해\n6.5. 이용자의 귀책 사유 또는 회사의 귀책 사유가 아닌 사유로 발생한 이용자의 피해\n\n제5조(서비스 이용계약의 성립)\n1. 회사와 회원의 서비스 이용계약은 서비스를 이용하고자 하는 자(이하 \"가입 신청자\"라고 합니다)가 서비스 내부의 회원가입 양식에 따라 필요한 회원정보를 기입하고, 이 약관, 개인정보 수집 및 이용 동의 등에 명시적인 동의를 한 후, 신청한 회원가입 의사 표시(이하 \"이용신청\"이라 합니다)를 회사가 승낙함으로써 체결됩니다.\n2. 제1항의 승낙은 신청순서에 따라 순차적으로 처리되며, 회원가입의 성립 시기는 회사의 회원가입이 완료되었음을 알리는 승낙의 통지가 회원에게 도달하거나, 이에 준하는 권한이 회원에게 부여되는 시점으로 합니다.\n3. 회사는 만 15세 미만 이용자의 이용신청을 금지하고 있습니다. 가입 신청자는 이용신청 시 만 15세 이상에 해당한다는 항목에 명시적인 동의를 함으로써 회원은 만 15세 이상임을 진술하고 보증합니다.\n4. 회사는 부정사용방지 및 본인확인을 위해 회원에게 본인 인증을 요청할 수 있습니다.\n5. 회사는 가입 신청자의 이용신청에 있어 다음 각 호에 해당하는 경우, 이용신청을 영구적으로 승낙하지 않거나 유보할 수 있습니다.\n5.1. 회사가 정한 이용신청 요건에 충족되지 않을 경우\n5.2. 가입 신청자가 만 15세 미만인 경우<\n5.3. 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우<\n5.4. 회사의 기술 및 설비 상 서비스를 제공할 수 없는 경우\n5.5. 기타 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우\n\n회사는 제3항부터 제5항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제6조(개인정보의 관리 및 보호)\n 1. 회사는 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 이용에 관해서는 관련 법령 및 회사의 개인정보 처리방침을 따릅니다.\n 2. 회원은 가입 시 개인정보에 기입한 이후 변동할 수 없기에 가입 시 신중하게 개인정보를 입력해야 합니다.\n 3. 회원의 아이디, 비밀번호 등 모든 개인정보의 관리책임은 본인에게 있으므로, 타인에게 양도 및 대여할 수 없으며 유출되지 않도록 관리해야 합니다. 만약 본인의 아이디 및 비밀번호를 타인이 사용하고 있음을 인지했을 경우, 즉시 문의 창구로 알려야 하고, 안내가 있는 경우 이에 따라야 합니다.\n 4. 회사는 회원이 제2항과 제3항을 이행하지 않아 발생한 피해에 대해, 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다. \n\n제7조(서비스 이용계약의 종료)\n 1. 회원은 언제든지 본인의 계정으로 로그인한 뒤 서비스 내부의 문의창구를 통해 탈퇴를 요청할 수 있습니다. 회사는 해당 요청을 확인한 후 탈퇴를 처리합니다.\n 2. 회원은 탈퇴 처리가 완료 되었더라도, 회원이 게시한 게시물은 삭제되지 않습니다.\n 3. 회사는 회원이 제11조(금지행위)에 해당하는 행위를 하거나 해당하는 행위를 했던 이력이 있을 경우, 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n 4. 회사는 제1항부터 제4항까지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제8조(회원에 대한 통지)\n 1. 회사가 회원에 대한 통지가 필요한 경우, 회원의 연락처 또는 서비스 내부 알림 수단을 이용할 수 있습니다.\n 3. 회사는 회원 전체에 대한 통지의 경우 공지사항에 게시함으로써 전 항의 통지에 갈음할 수 있습니다. 단, 회원의 권리 및 의무에 중대한 영향을 미치는 사항에 대해서는 1항에 따릅니다.\n 4. 회사가 회원에게 ‘30일 이내에 의사를 표시하지 아니할 경우 동의한 것으로 간주한다’는 내용을 고지하였음에도 불구하고 회원이 의사를 표시하지 아니하면, 회사는 통지 내용에 동의한 것으로 간주합니다.\n\n제9조(저작권의 귀속)\n 1. 회사는 유용하고 편리한 서비스를 제공하기 위해, 2023년부터 서비스 및 서비스 내부의 기능을 직접 설계 및 운영하고 있는 데이터베이스 제작자에 해당합니다. 회사는 저작권법에 따라 데이터베이스 제작자는 복제권 및 전송권을 포함한 데이터베이스 전부에 대한 권리를 가지고 있으며, 이는 법률에 따라 보호를 받는 대상입니다. 그러므로 이용자는 데이터베이스 제작자인 회사의 승인 없이 데이터베이스의 전부 또는 일부를 복제·배포·방송 또는 전송할 수 없습니다.\n 2. 회사가 작성한 게시물에 대한 권리는 회사에 귀속되며, 회원이 작성한 게시물에 대한 권리는 회원에게 귀속됩니다.\n 3. 회원이 서비스에 게시물을 작성하는 경우 해당 게시물은 서비스에 노출될 수 있고 필요한 범위 내에서 사용, 저장, 복제, 수정, 공중송신, 전시, 배포 등의 방식으로 해당 게시물을 이용할 수 있도록 허락하는 전 세계적인 라이선스를 회사에 제공하게 됩니다. 이 경우, 회사는 저작권법을 준수하며 회원은 언제든지 문의 창구 및 서비스 내부의 관리 기능이 제공되는 경우에는 해당 관리 기능을 이용하여 가능한 범위에 한해 해당 게시물에 대한 삭제, 수정, 비공개 등의 조치를 취할 수 있습니다.\n 4. 회사는 제3항 이외의 방법으로 회원의 게시물을 이용할 경우, 해당 회원으로부터 개별적이고 명시적인 동의를 받아야 합니다.\n\n제10조(게시물의 삭제 및 접근 차단)\n 1. 누구든지 게시물로 인해 사생활 침해나 명예훼손 등 권리가 침해된 경우 회사에 해당 게시물의 삭제 또는 반박내용의 게재를 요청할 수 있습니다. 이 때 회사는 해당 게시물을 삭제할 수 있습니다.\n 2. 회사가 제1항에 따라 회원의 게시물을 삭제하거나 접근을 임시적으로 차단하는 경우, 해당 게시물이 작성된 커뮤니티에 필요한 조치를 한 사실을 명시하고, 불가능한 사유가 없을 경우 이를 요청한 자와 해당 게시물을 작성한 회원에게 그 사실을 통지합니다.\n\n제11조(금지행위)\n 1. 이용자는 다음과 같은 행위를 해서는 안됩니다. \n - 성적 도의관념에 반하는 행위 (정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따른 유해정보 유통 행위, 전기통신사업법에 따른 불법촬영물등 유통 행위, 청소년보호법에 따른 청소년유해매체물 유통 행위, 방송통신심의위원회의 정보통신에 관한 심의규정에 따른 심의기준의 성적 도의관념에 반하는 행위, 커뮤니티 이용규칙 금지행위에 따른 불건전 만남, 유흥, 성매매 등 내용 유통 행위)\n - 홍보/판매 행위(이 약관이 적용되는 서비스 및 기능과 동일하거나 유사한 서비스 및 기능에 대한 직·간접적 홍보 행위, 비상업적 목적의 일상 생활과 관련된 중고 품목 이외의 품목 등 커뮤니티 이용규칙 금지행위에 따른 홍보 및 판매 행위), \n - 개인정보 또는 계정 기만, 침해, 공유 행위(개인정보를 허위, 누락, 오기, 도용하여 작성하는 행위, 타인의 개인정보 및 계정을 수집, 저장, 공개, 이용하는 행위, 자신과 타인의 개인정보를 제3자에게 공개, 양도, 승계하는 행위, 다중 계정을 생성 및 이용하는 행위, 자신의 계정을 이용하여 타인의 요청을 이행하는 행위)\n - 시스템 부정행위(프로그램, 스크립트, 봇을 이용한 서비스 접근 등 사람이 아닌 컴퓨팅 시스템을 통한 서비스 접근 행위, API 직접 호출, 유저 에이전트 조작, 패킷 캡처, 비정상적인 반복 조회 및 요청 등 허가하지 않은 방식의 서비스 이용 행위, 회사의 모든 재산에 대한 침해 행위)\n - 업무 방해 행위(서비스 관리자 또는 이에 준하는 자격을 허가 없이 취득하여 권한을 행사하거나, 사칭하여 허위의 정보를 발설하는 행위, 회사 및 타인의 명예를 훼손하거나 기타 업무를 방해하는 행위, 서비스 내부 정보 일체를 허가 없이 이용, 변조, 삭제 및 외부로 유출하는 행위)\n - 기타 현행법에 어긋나거나 부적절하다고 판단되는 행위\n 2. 이용자는 제1항에 기재된 내용 외에 이 약관과 커뮤니티 이용규칙에서 규정한 내용에 반하는 행위를 해서는 안됩니다.\n 3. 이용자가 제1항에 해당하는 행위를 할 경우, 회사는 이 약관 제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)에 따라 서비스 제공을 중단하거나 서비스 이용계약을 해지할 수 있습니다.\n\n제12조(서비스 제공의 중단 및 서비스 이용계약의 해지)\n 1. 이용자가 이 약관 및 커뮤니티 이용규칙에서 이 조항 적용이 명시된 금지행위 및 이에 준하는 행위를 할 경우, 회사는 서비스 보호를 위해 다음과 같은 조치를 최대 영구적으로 취할 수 있습니다. (회원의 서비스 이용 권한, 자격, 혜택 제한 및 회수, 회원과 체결된 이용계약의 해지, 회원가입, 본인 인증, 회원의 커뮤니티, 게시물, 닉네임, 이용 기록을 삭제, 중단, 수정, 변경, 그 외 서비스의 정상적인 운영을 위해 회사가 필요하다고 판단되는 조치)\n 2. 회사는 서비스 제공 중단 및 서비스 이용계약 해지 시, 회원의 연락처 또는 서비스 내부 알림 수단을 통하여 그 사실을 사유와 함께 개별 통지합니다. 회원은 해당 통지를 받은 날로부터 7일 이내에 문의 창구로 이의를 제기할 수 있습니다.\n 3. 회사는 이용자의 귀책 사유로 인한 서비스 제공 중단 및 서비스 이용계약의 해지로 인해 발생한 피해에 대해 회사의 고의 또는 중대한 과실이 없는 한 어떠한 책임도 지지 않습니다.\n\n제13조(재판권 및 준거법)\n 1. 회사와 이용자 간에 발생한 분쟁에 관한 소송은 민사소송법상의 관할 법원에 제소합니다.\n 2. 회사와 이용자 간에 제기된 소송에는 대한민국 법을 준거법으로 합니다.\n\n제15조(기타)\n\n 1. 이 약관은 2023년 1월 12일에 개정되었습니다.\n 2. 이 약관에도 불구하고, 회사와 이용자가 이 약관의 내용과 다르게 합의한 사항이 있는 경우에는 해당 내용을 우선으로 합니다. \n 3. 회사는 필요한 경우 약관의 하위 규정을 정할 수 있으며, 이 약관과 하위 규정이 상충하는 경우에는 이 약관의 내용이 우선 적용됩니다.\n 4. 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관련법 또는 관례에 따릅니다.",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w500),
                          ))),
                ])));
  }
}
