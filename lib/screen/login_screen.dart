import 'package:byourside/widget/social_button_from.dart';
import 'package:flutter/material.dart';
import '../size.dart';
import '../widget/custom_form.dart';
import '../widget/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.primaryColor}) : super(key: key);
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // SizedBox(height: xlarge_gap),
            Logo("Login"),
            SizedBox(height: large_gap), // 1. 추가
            CustomForm(), // 2. 추가
            SocialButtonForm("kakao"),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatefulWidget {
//   // final Login login;
//   // LoginScreen({required this.login});
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class Login {
//   String id = "";
//   String password = "";
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool login = false;
//   bool _isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Post page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(32),
//                   child: Image.asset("images/hug 1.png", width: 50,),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Image.asset("images/곁.png", width: 120,),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: "아이디"),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: "비밀번호"),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       width: double.infinity,
//                       margin: EdgeInsets.only(top: 24),
//                       child: ElevatedButton(onPressed: () {}, child: Text("로그인"))),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextButton(onPressed: () { }, child: Text("자동로그인"),),
//                       TextButton(onPressed: () { }, child: Text("|   회원가입"),),
//                       TextButton(onPressed: () { }, child: Text("|   아이디/비밀번호 찾기"),),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             width: 50,
//                             height: 50,
//                             child: InkWell(
//                               radius: 100,
//                               onTap: () {
//                                 ScaffoldMessenger.of(context).clearSnackBars();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('kakao'),
//                                   duration: Duration(milliseconds: 1500),
//                                   ),
//                                 );
//                               },
//                               child: Ink.image(
//                                   fit: BoxFit.cover,
//                                   image: const NetworkImage(
//                                       'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
//                             ),
//                           )
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                               width: 50,
//                               height: 50,
//                               child: InkWell(
//                                 radius: 100,
//                                 onTap: () {
//                                   ScaffoldMessenger.of(context).clearSnackBars();
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('kakao'),
//                                       duration: Duration(milliseconds: 1500),
//                                     ),
//                                   );
//                                 },
//                                 child: Ink.image(
//                                   fit: BoxFit.cover,
//                                   image: const NetworkImage(
//                                       'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
//                                 ),
//                               )
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                               width: 50,
//                               height: 50,
//                               child: InkWell(
//                                 radius: 100,
//                                 onTap: () {
//                                   ScaffoldMessenger.of(context).clearSnackBars();
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('kakao'),
//                                       duration: Duration(milliseconds: 1500),
//                                     ),
//                                   );
//                                 },
//                                 child: Ink.image(
//                                   fit: BoxFit.cover,
//                                   image: const NetworkImage(
//                                       'https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg'),
//                                 ),
//                               )
//                           ),
//                         )
//                       ]
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
