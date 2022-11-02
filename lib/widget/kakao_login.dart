// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//
// class KakaoLogin extends StatefulWidget {
//   const KakaoLogin({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return KakaoLoginState();
//   }
// }
//
// class KakaoLoginState() extends State<KakaoLogin> {
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   KakaoSdk.init(
//   nativeAppKey: 'e21ce682ef29e8242a6255d692e866ea',
//   javaScriptAppKey: 'e0db44eb2872ac3399b5e148ab3d8873',
//   );
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   void signInWithKakao() async {
//     try {
//       bool isInstalled = await isKakaoTalkInstalled();
//
//       OAuthToken token = isInstalled
//           ? await UserApi.instance.loginWithKakaoTalk()
//           : await UserApi.instance.loginWithKakaoAccount();
//
//       final url = Uri.https('kapi.kakao.com', '/v2/user/me');
//
//       final response = await http.get(
//         url,
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
//         },
//       );
//
//       final profileInfo = json.decode(response.body);
//       print(profileInfo.toString());
//
//       setState(() {
//         _loginPlatform = LoginPlatform.kakao;
//       });
//
//     } catch (error) {
//       print('카카오톡으로 로그인 실패 $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     );
//   }
//
// }
//
